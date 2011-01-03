require 'fileutils'
require 'zip/zip'
require 'zip/zipfilesystem'

task :default do

  abort("Supported tasks: doc_linux, doc_windows")

end

def run_tests( name, command_line )

  begin

    Dir.chdir("test")

    puts "Removing old test results...\n"

    Dir.glob( "feature_xml/*.xml" ){ | file |  

      begin

        FileUtils.rm( file ) 

      rescue Exception => exception

        puts "Error while removing file %s (%s: %s)" % [ file, exception.class, exception.message ]

      end

    }

    puts "Executing documentation #{ name } feature tests...\n"
    result=system( command_line )

  ensure

    Dir.chdir("..")

  end
  result

end

task :doc_linux do 

  run_tests( "linux", "cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_linux" )

end

task :doc_meego do 

  run_tests( "meego", "cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_meego" )

end

task :doc_windows do 

  run_tests( "windows", "cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_windows" )

end

task :doc_symbian do 

  run_tests( "symbian", "cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_symbian" )

end


desc "Task for executing smoke tests"
task :execute_smoke do

  puts "#########################################################"
  puts "### Executing smoke tests                            ####"
  puts "#########################################################"
  begin

  Dir.chdir('test/tc_testapp')
  cmd = "ruby tc_testapp.rb"
  failure = system(cmd)
  
  raise "smoke test failed" if (failure != true) or ($? != 0) 
	
  ensure
  Dir.chdir("../../")
    if ENV['CC_BUILD_ARTIFACTS']    
    #Copy results to build artifacts
	  Dir.foreach("#{Dir.pwd}/test/tc_testapp/tdriver_reports") do |entry|
	    if entry.include?('test_run')
	      FileUtils.cp_r "#{Dir.pwd}/test/tdriver_reports/#{entry}", "#{ENV['CC_BUILD_ARTIFACTS']}/#{entry}"
          FileUtils::remove_entry_secure("#{Dir.pwd}/test/tdriver_reports/#{entry}", :force => true)
	    end
	  end
    end    

  end
  raise "Smoke tests failed" if (result != true) or ($? != 0) 
  result
end

desc "Task for building the example QT application(s)"
task :build_testapps do

  puts "#########################################################"
  puts "### Building test applications                        ####"
  puts "#########################################################"

	# buid version file
	#File.open('common/inc/version.h', 'w') { |f| f.write "static QString TAS_VERSION = \"#{@__tas_revision}\";" }  
  make = "make"
  sudo = ""	

  if /win/ =~ RUBY_PLATFORM
    make = "mingw32-make"
  else
    sudo = "echo \"testability\" | sudo -S "
  end
  cmd = sudo + " #{make} uninstall"
  system(cmd)

  cmd = "#{make} distclean"
  system(cmd)
  
  cmd = "qmake CONFIG+=release"
  failure = system(cmd)
  raise "qmake failed" if (failure != true) or ($? != 0) 
    
  cmd = "#{make}"
  failure = system(cmd)
  raise "make release failed" if (failure != true) or ($? != 0) 
    
  cmd = sudo + "#{make} install"
  failure = system(cmd)
  raise "make install failed" if (failure != true) or ($? != 0) 
  puts "Testapps built"
end

task :cruise => ['build_testapps','execute_smoke'] do
  if /win/ =~ RUBY_PLATFORM
    result=run_tests( "windows", "cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_windows" )
  else
    result=run_tests( "linux", "cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_linux" )
  end  
  
  puts "Feture tests executed" 
   if ENV['CC_BUILD_ARTIFACTS']    
    #Copy results to build artifacts
	Dir.foreach("#{Dir.pwd}/test/tdriver_reports") do |entry|
	  if entry.include?('test_run')
	    FileUtils.cp_r "#{Dir.pwd}/test/tdriver_reports/#{entry}", "#{ENV['CC_BUILD_ARTIFACTS']}/#{entry}"
        FileUtils::remove_entry_secure("#{Dir.pwd}/test/tdriver_reports/#{entry}", :force => true)
	  end
	end
    #Zip the generated xml documentation
	filename = "#{ENV['CC_BUILD_ARTIFACTS']}/feature_xml.zip"
	root="#{Dir.pwd}/test/feature_xml"
	Zip::ZipFile.open(filename, 'w') do |zipfile|
      Dir["#{root}/*"].reject{|f|f==filename}.each do |file|
        zipfile.add(file.sub(root+'/',''),file)
      end
    end	
   end
   raise "Feature tests failed" if (result != true) or ($? != 0) 
   exit(0)
end


