############################################################################
##
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
## All rights reserved.
## Contact: Nokia Corporation (testabilitydriver@nokia.com)
##
## This file is part of TDriver.
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


# Author: Mika Leiman
# Date: 5.1.2011
# Purpose: Test TDriver methods

require 'tdriver'
include TDriverVerify
include TDriverReportAPI

Before do
  	
  @verify_timeout=0 if @verify_timeout==nil

  $on_error_verify_block_executed = nil

end

def call_verify_method( _method, _timeout, message = nil )

    case _method

      when /^verify$/
        verify(_timeout, message){ raise MobyBase::VerificationError }
        
      when /^verify_not$/
        verify_not(_timeout, message){}

      when /^verify_false$/
        verify_false(_timeout, message){ true }

      when /^verify_true$/
        verify_true(_timeout, message){ false }

      when 'verify_equal'
        verify_equal(0, _timeout, message){ 1 }

      when /^verify_less$/
        verify_less(0, _timeout, message){ 1 }

      when /^verify_greater$/
        verify_greater(1, _timeout, message){ 0 }

      when /^verify_signal$/
        button1  = @sut.application.Button(:objectName => "zeroButton")
        # retrieving object takes some time...
        @verify_start_time = Time.now
        button1.verify_signal( _timeout, 'clicked()', message ){}

      when /^verify_regexp$/
        verify_regexp( /^true$/, _timeout, message ){ "false" }

    else

      raise ArgumentError, 'unknown verify method ' << _method.to_s.downcase

    end

end

Given /^I call ([^\"]*) with timeout (\d+)$/ do | _method, _timeout |
    
    @verify_timeout = 0

    begin      

      @verify_start_time = Time.now

      call_verify_method( _method, _timeout.to_i )

    rescue MobyBase::VerificationError

      # do nothing

    end 
       
    @verify_timeout = Time.now - @verify_start_time

    tdriver_report_log( "Verify timeout in #{ @verify_timeout }s")
    
end

Given /^I call ([^\"]*) with no timeout value$/ do | _method |
    
    @verify_timeout = 0

    begin      

      @verify_start_time = Time.now

      call_verify_method( _method, nil )

    rescue MobyBase::VerificationError

      # do nothing

    end

    @verify_timeout = Time.now - @verify_start_time

    tdriver_report_log( "Verify timeout in #{ @verify_timeout }s")
    
end


Then ("the verify should timeout in $timeout") do |timeout|

  verify_true(0){ @verify_timeout.to_f >= timeout.to_f }
  #verify_true(0){@verify_timeout.to_f < timeout.to_f+3} # why +3 seconds?
end

And /^I set default sychronization timeout to (\d+)$/ do | _timeout |

  @original_default_timeout = TDriver::Parameter[:synchronization_timeout]
  
  TDriver::Parameter[ :synchronization_timeout ] = _timeout.to_i

end

Then /restore to default sychronization timeout value/ do

  TDriver::Parameter[ :synchronization_timeout ] = @original_default_timeout

end


Then ("the verify should timeout with default synchronization value") do

  verify_true(){@verify_timeout.to_f >= TDriver::Parameter[:synchronization_timeout].to_i}
  #verify_true(){@verify_timeout.to_f < TDriver::Parameter[:synchronization_timeout].to_i+3} # why +3 seconds?

end

Then ("I call verify_signal to catch signal $signal with no message") do | signal |

    button1  = @sut.application.Button(:objectName => "zeroButton")

    button1.verify_signal( 10, signal ){ button1.tap }

end

When /I call ([^\"]*) with with custom error message/ do | _method |

  begin

    @__custom_message = "__custom message with #{ _method.to_s }__"
  
    call_verify_method( _method, 0, @__custom_message )

  rescue

    @__exception_message = $!.message.to_s
  
  end

end

p method(:Then).methods.sort

Then ("given message is in exception details") do

  verify_regexp(/#{ @__custom_message.inspect }/, 0, "exception did not contain custom error message: #{ @__custom_message.inspect }"){ @__exception_message }

end


Then ("I call verify_signal to catch signal $signal with message \"$msg\"" )do | signal, msg |

  button1  = @sut.application.Button( :objectName => "zeroButton" )

  begin
  
    button1.verify_signal( 0, signal, msg ){}
    
  rescue
    
    verify_regexp(/#{ msg.inspect }/, 0, "exception did not contain the message: #{ msg.inspect }"){ $!.message.to_s }
  
  end
  
end

And("I $status on_error_verify block" ) do | status |

  case status

    when /enable/i
    
      $on_error_verify_block_executed = false

      on_error_verify_block{  $on_error_verify_block_executed = true }

    when /disable/i

        $on_error_verify_block_executed = nil

        reset_on_error_verify_block

  else

  end  
  # set
  # disable

end
   
And("I call $method that $status" ) do | method, status |

      case status

# FAILS
        when /fails/

          begin

            @failed = false

            case method

              when /^verify$/
                verify( 0, "" ){ raise ArgumentError.new("error") }

              when /verify_not/
                verify_not( 0, "" ){ nil }

              when /verify_true/
                verify_true( 0, "" ){ false }

              when /verify_false/
                verify_false( 0, "" ){ true }

              when /verify_equal/
                verify_equal( "0", 0 ){ 1 }

              when /verify_less/
                verify_less( 0, 0 ){ 1 }

              when /verify_greater/
                verify_greater( 1, 0 ){ 0 }

              when /verify_regexp/
                verify_regexp( /a/, 0 ){ 'b' }

              when /verify_signal/
                button1  = @sut.application.Button(:objectName => "zeroButton")
                button1.verify_signal(0, 'unknownSignal()' ){}

            else

              raise ArgumentError.new( "invalid verify method" )

            end  

          rescue Exception => exception
      
            # pass
            @failed = true if [ MobyBase::VerificationError ].include?( exception.class )
  
          ensure 

            raise ArgumentError.new( "should have failed" ) unless @failed

          end

        when /passes/

          begin
  
            case method

              when /^verify$/
                verify( 0, "" ){ nil }

              when /verify_not/
                verify_not( 0, "" ){ raise ArgumentError.new("error") }

              when /verify_true/
                verify_true( 0, "" ){ true } 

              when /verify_false/
                verify_false( 0, "" ){ false }

              when /verify_equal/
                verify_equal( "0", 0 ){ "0" }

              when /verify_less/
                verify_less( 1, 0 ){ 0 }

              when /verify_greater/
                verify_greater( 0, 0 ){ 1 }

              when /verify_regexp/
                verify_regexp( /a/, 0 ){ 'a' }

              when /verify_signal/
                @button  = @sut.application.Button(:objectName => "zeroButton")
                @button.verify_signal(10, 'clicked()' ){
                  @button.tap
                }

            else

              raise ArgumentError.new( "invalid verify method" )

            end  

          rescue Exception => exception
      
            raise exception       
  
          end

      else

        raise ArgumentError.new( "invalid status" )

      end

end

Then("user defined code block $status be executed" ) do | status |

  case status

    when /will/
      verify_true( 0, "" ){ $on_error_verify_block_executed == true }

    when /won't/
      verify_true( 0, "" ){ [ false, nil ].include?( $on_error_verify_block_executed ) }

  else

    raise ArgumentError.new( "invalid status" )

  end

  $on_error_verify_block_executed = false

end


