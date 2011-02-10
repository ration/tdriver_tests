############################################################################
## 
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
## All rights reserved. 
## Contact: Nokia Corporation (testabilitydriver@nokia.com) 
## 
## This file is part of MATTI. 
## 
## If you have questions regarding the use of this file, please contact 
## Nokia at testabilitydriver@nokia.com . 
## 
## This library is free software; you can redistribute it and/or 
## modify it under the terms of the GNU Lesser General Public 
## License version 2.1 as published by the Free Software Foundation 
## and appearing in the file LICENSE.LGPL included in the packaging 
## of this file. 
## 
############################################################################

#require 'mocha'
require 'date'
require 'time'

require 'test/unit/testsuite'
require 'test/unit/ui/console/testrunner.rb'

module TDriverTestSuite

	VERSION = "0.0.2" unless VERSION

	def self.matti_root( folder = nil )
		folder = caller.first if !folder
		File.expand_path( folder.split( /:[0-9]+/ ).first ).split( /[\/|\\]+/ ).tap{ | path |
			return "#{ path.slice( 0 .. @index - 1 ).join( File::SEPARATOR ) }#{ File::SEPARATOR }" if !( @index = self.rindex_regexp( path, /^test$/i ) ).nil?
		} 
		Kernel::raise RuntimeError.new("Tests must be located /matti/test/ -folder/subfolder")
	end

	def self.test_folder( folder = nil )
		folder = caller.first if !folder
		return "#{ self.matti_root( folder ) }test#{ File::SEPARATOR }"
	end

	def self.test_data_folder( folder = nil )
		folder = caller.first if !folder
		return "#{ self.test_folder( folder ) }test_data#{ File::SEPARATOR }"
	end

	def self.current_folder()
		return File.expand_path( File.dirname( caller.first.split( /:[0-9]+/ ).first ) )
	end

	def self.execute_tests( file_pattern = "tc_*.rb", folder = nil, show_message = true )
		folder = caller.first if !folder
		File.expand_path( File.dirname( folder.split( /:[0-9]+/ ).first ) ).tap{ | path |
			puts "executing test set from directory: #{ path  }" if show_message
			Dir.glob( File.join( path, file_pattern ) ).each { | filename | require filename  }
		}    
	end

	#  private

	def self.rindex_regexp( array, pattern )
		Kernel::raise TypeError.new("Unexpected variable type '%s' for array (Expected: %s)" % [ array.class, 'Array'] ) unless array.kind_of?( Array )
		Kernel::raise TypeError.new("Unexpected variable type '%s' for regular expression pattern (Expected: %s)" % [ pattern.class, 'Regexp'] ) unless pattern.kind_of?( Regexp )  
		# return nil if no matches found, otherwise return index of value
		return nil if ( array.reverse.each_index{ | index | return @rindex if array[ ( @rindex = ( ( array.size-1 ) - index ) ) ] =~ pattern; } )
	end

	class EnduranceRunner

		@@results = { :asserts => 0, :errors => 0, :fails => 0, :passed => 0, :tests => 0 } 

		@@tests = []
		@@testcases = 0
	    
		# Executes the given test suite for a specified duration
		# prints statistics about execution times
		#
		# ==params
		# endurance_suite:: String with path to ruby file containing the declaration of enrudance test suite, relative to MATTI_HOME
		# duration:: Integer defining how long the test should be executed, in minutes
		# ==returns
		# Boolean:: true if the execution was completed succesfully, false otherwise 
	    
		def self.add_file( tests )

			tests = [ tests ] unless tests.kind_of?( Array )

			tests.each{ | filename |

				# expand wildcards to array if found
				testsuites = ( filename.include?( '*' ) ? ( ( tmp = Dir.glob( filename ) ).empty? ? [ filename ] : tmp ): [ filename ] )

				testsuites.each{ | testsuite_filename |

					if File.exist?( testsuite_filename )  
						require testsuite_filename
					else
						Kernel::raise LoadError.new( "Unable to add testcase to suite due to file not found (#{ testsuite_filename })" )
					end

				}

			}

			ObjectSpace.each_object( Class ){ | test_class |
				if test_class.ancestors.include?( Test::Unit::TestCase ) && test_class != Test::Unit::TestCase
					unless @@tests.include? test_class
						puts "#{ test_class.to_s }:"
						test_class.public_instance_methods( false ).sort.each{ | method | 
							if method =~ /^test_/ 
								@@testcases += 1; puts "\t#{ method }"; 
							end
						}
						puts "\n"
						@@tests.push test_class 
					end
				end
			}

		end

		# Get execute rules from command line arguments
		# ==returns
		# Hash:: Hash of execute rules
		def self.get_command_line_arguments()

			@arguments = {}
			key = nil

			ARGV.each{ | argument | 

				if /^\-\-/.match( argument )

					@arguments[ ( key = argument.gsub("-", "").to_sym ) ] = ""

				else

					Kernel::raise ArgumentError.new("Invalid option: #{ argument }") if key.nil?
					Kernel::raise ArgumentError.new("Too many values for argument #{ key }") unless @arguments[ key ].empty?

					@arguments[ key ] = ( [ :date, :time, :exception ].include? key ) ? argument : argument.to_i

				end

			}

			ARGV.clear

			@arguments

		end

		# Executes the given test suite with given rule
		#  s statistics about execution times
		#
		# ==params
		# rules:: Hash defining how long or how many times the test should be executed valid keys are :times, :date, :time, :days, :hours, :minutes, :seconds
		# ==returns
		# Boolean:: true if the execution was completed succesfully, false otherwise 
		def self.execute( rules = { :times => 1 } )

			rules = get_command_line_arguments() if ARGV.count > 0

			# raise exception if rules argument variable type other than hash
			Kernel::raise ArgumentError.new("Unexpected argument variable type for rules (Expected: Hash, Actual: #{ rules.class })") unless rules.kind_of?( Hash ) 

			# raise exception if duration / times values are use at same time
			Kernel::raise ArgumentError.new("Use :times or :time, :date, :days, :hours, :minutes, :seconds") if ( rules[:time] || rules[:date] || rules[:days] || rules[:hours] || rules[:minutes] || rules[:seconds] ) && rules[:times]

			# raise exception if value type of :times other than integer
			Kernel::raise TypeError.new("Unexpected argument variable type for :times (Expected: Integer, Actual: #{ rules[:times].class })") if rules[:times] && !rules[:times].kind_of?( Integer )

			# raise exception if no tests added for execution
			#Kernel::raise TypeError.new("No tests cases to run, use TDriverTestSuite::EnduranceRunner.add_file( filename ) to add tests to suite") if @@testcases == 0 

			mode = ( rules[ :time ] || rules[ :date ] || rules[ :days ] || rules[ :hours ] || rules[ :minutes ] || rules[ :seconds ] ) ? :duration : ( rules[ :times ] ? :times : nil )

			# defaults
			@@results = { :asserts => 0, :errors => 0, :fails => 0, :passed => 0, :tests => 0 } 

			@@exceptions = []

			# create test suite
			test_suite = Test::Unit::TestSuite.new( 'suite' )

			# apply loaded tests to suite
			@@tests.each{ | testname | test_suite << testname.suite }

			# store time when testing started
			start_time = Time.now

			if mode == :times
				puts "Executing test suite with #{ @@testcases } test cases(s) for #{ rules[:times] } times."
			else
				end_time, total_seconds, days, hours, mins, secs = self.get_time( rules )
				puts "Executing test suite with #{ @@testcases } test case(s) for #{ days } days, #{ hours } hours, #{ mins } minutes and #{ secs.round } seconds."
			end

			iteration = 0

			# stop test execution if given exception occures
			stop_when_exception = rules.has_key?( :exception ) ? rules[ :exception ].to_s.split(",") : nil

			stop_testing = false

			loop do

        break if $exit

				if mode == :times
					break if iteration >= rules[ :times ]
					puts "#{ Date.today } #{ iteration_start_time = Time.now }: Suite iteration #{ iteration += 1 }/#{ rules[:times] }\n"
				else
					break if Time.now >= end_time
					days, hours, mins, secs = self.convert_seconds_to_time( end_time - ( iteration_start_time = Time.now ) )
					puts "#{ Date.today } #{ iteration_start_time }: Suite iteration #{ iteration += 1 } - test execution time left #{ days }d #{ hours }h #{ mins }m #{ secs.round }s.\n"
				end

				results = Test::Unit::UI::Console::TestRunner.run( test_suite )

				iteration_end_time = Time.now

				if results.instance_eval( '@errors' ).count > 0

					results.instance_eval( '@errors' ).each{ | error |

						@@exceptions.push( error )

						# check if user defined exception was raised, stop testing if matches
						if !stop_when_exception.nil? && ( stop_when_exception.include?( error.exception.class.to_s ) || stop_when_exception.empty? )

							puts "\nException #{ error.exception.class.to_s } occured, stopping test execution..." if !stop_testing
							stop_testing = true 

						end
					}

				end

				if results.instance_eval( '@failures' ).count > 0
					results.instance_eval( '@failures' ).each{ | error |
						@@exceptions.push( error )
					}
				end


				# add last test results to total test results
				@@results[ :errors ] += results.instance_eval( '@errors' ).count
				@@results[ :fails ] += results.instance_eval( '@failures' ).count
				@@results[ :passed ] += results.run_count - ( results.instance_eval( '@errors' ).count + results.instance_eval( '@failures' ).count)
				@@results[ :asserts ] += results.assertion_count
				@@results[ :tests ] += results.run_count

				break if stop_testing

			end

			@@results[ :passed ] = 0 if @@results[ :passed ] < 0

			puts "\n#{ Date.today } #{ finish_time = Time.now }: Execution finished\n\n"

			days, hours, mins, secs = self.convert_seconds_to_time( finish_time - start_time )

			if @@exceptions.count > 0 				
				puts "Exceptions:\n\n"
				@@exceptions.each_index{ | index | 
					error_type = nil
					details = ""
					case @@exceptions[ index ].class.to_s					
						when "Test::Unit::Failure"
							error_type = 'Failure'
							details += "#{ @@exceptions[ index ].location.collect{ | x | "\t\t#{ x }\n" }  }"
							details += "\t\t#{ @@exceptions[ index ].message.gsub("\n", "\n\t\t")  }\n"
						when "Test::Unit::Error"
							error_type = 'Error'
							details += "\t\t#{ @@exceptions[ index ].exception.class }: #{ @@exceptions[ index ].exception.message }\n"
							details += "#{ 
								@backtrace_print = true; 
								@@exceptions[ index ].exception.backtrace.collect{ | caller_method | 									
									@backtrace_print = false if caller_method =~ /\/test\/unit\/testsuite\.rb/
									@backtrace_print ? "\t\t#{ caller_method }\n" : nil
								}.compact
							  }"
					else
						error_type = 'Unknown error type'
						details += @@exceptions[ index ].inspect
						# Unknown error type
					end
					puts "\t#{ index + 1 }) #{ error_type } in #{ @@exceptions[ index ].test_name }:\n#{ details }\n"
				}
			end

			puts "Suite executed #{ iteration } times for #{ days } days, #{ hours } hours, #{ mins } minutes and #{ secs.round } seconds.\n"
			puts "Total runtime time in seconds: #{finish_time - start_time}. Average iteration time in seconds: #{ ( finish_time - start_time ) / iteration }\n"
			puts "#{ @@results[ :tests ] } tests, #{ @@results[ :passed ] } passed, #{ @@results[ :asserts ] } assertions, #{ @@results[ :fails ] } failures and #{ @@results[ :errors ] } errors.\n\n"

			return ( ( @@results[ :fails ] > 0 || @@results[ :errors ] > 0 ) ? false : true )

		end

		def self.convert_seconds_to_time( seconds )

			days = hours = mins = 0

			if seconds >=  60 then

				mins = ( seconds / 60 ).to_i 
				seconds = ( seconds % 60 ).to_i

				if mins >= 60 then
					hours = ( mins / 60 ).to_i 
					mins = ( mins % 60 ).to_i
				end

				if hours >= 24 then
					days = ( hours / 24 ).to_i
					hours = ( hours % 24 ).to_i
				end

			end

			[ days, hours, mins, seconds ]

		end


		def self.get_time( time_hash )

			run_time = ( current_time = Time.now )

			if time_hash[ :date ]
				Kernel::raise ArgumentError.new('Use :date or :days, :hours, :minutes and :seconds') if time_hash[:days] || time_hash[ :hours ] || time_hash[ :minutes ] || time_hash[ :seconds ]
				run_time = Time.parse( time_hash[ :date ] )
			end

			if time_hash[ :time ] 
				Kernel::raise ArgumentError.new('Use :time or :hours, :minutes and :seconds') if time_hash[ :hours ] || time_hash[ :minutes ] || time_hash[ :seconds ]
				run_time = ( run_time - ( ( run_time.hour * 60 * 60 ) + ( run_time.min * 60 ) + run_time.sec ) ) + ( Time.parse( time_hash[:time] ) - Time.parse( '00:00:00' ) ) 
				run_time += ( 24 * 60 * 60 ) if run_time < current_time && !time_hash[ :date ]
			end

			if time_hash[:days]
				Kernel::raise ArgumentError.new('Use :date or :days, :hours, :minutes and :seconds') if time_hash[ :date ]
				run_time = ( run_time ) + ( 60 * 60 * 24 * time_hash[ :days ] ) 
			end

			if time_hash[ :hours ] || time_hash[ :seconds ] || time_hash[ :minutes ]
				Kernel::raise ArgumentError.new( 'Use :time or :hours, :minutes and :seconds' ) if time_hash[ :time ]
				run_time += ( 60 * 60 * time_hash[ :hours ]) if time_hash[ :hours ]
				run_time += ( 60 * time_hash[ :minutes ]) if time_hash[ :minutes ]
				run_time += ( time_hash[ :seconds ] ) if time_hash[ :seconds ]
			end

			Kernel::raise ArgumentError.new("Given execution time is less than current time") if run_time < current_time 

			days, hours, mins, seconds = self.convert_seconds_to_time( run_time - current_time )

			return [run_time, run_time - current_time, days, hours, mins, seconds]

		end


	    
	end # EnduranceRunner

end # TDriverTestSuite

# unittests with stats reporting: Finished in 40.789142 seconds.
# unittests without stats reporting: Finished in 85.681246 seconds.
$_MATTI_DISABLE_STATS_REPORTING = true

$exit = false

def trap_interrupt
 trap('INT') do
   exit!(1) if $exit
   $exit = true
   STDERR.puts "\nExiting after suite run is finished... Interrupt again to exit immediately."
 end
end

trap_interrupt
