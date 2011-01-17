require 'fileutils'
require 'zip/zip'
require 'zip/zipfilesystem'

task :default do

  abort("Supported tasks: doc_linux, doc_windows")

end

def generate_sut_qt_api_doc()
  if ENV['CC_BUILD_ARTIFACTS']
    begin
      current_dir=Dir.pwd
      puts 'Copying feature xml'
      Dir.mkdir("#{ENV['CC_BUILD_ARTIFACTS']}/tests")
      Dir.mkdir("#{ENV['CC_BUILD_ARTIFACTS']}/tests/test")
      Dir.mkdir("#{ENV['CC_BUILD_ARTIFACTS']}/tests/test/feature_xml")
      FileUtils.cp_r "#{Dir.pwd}/test/feature_xml", "#{ENV['CC_BUILD_ARTIFACTS']}/tests/test/feature_xml"

      puts 'Cloning sut qt'
      Dir.chdir(ENV['CC_BUILD_ARTIFACTS'])
      system("git clone git@gitorious.org:tdriver/driver.git")
      system("git clone git@gitorious.org:tdriver/sut_qt.git")
      Dir.chdir('sut_qt')

      puts 'Generating API doc'
      system("rake doc")
      Dir.chdir('..')
      puts 'Copy API doc to artifacts'
      FileUtils.cp_r "#{ENV['CC_BUILD_ARTIFACTS']}/sut_qt/doc/output/.", "#{ENV['CC_BUILD_ARTIFACTS']}"

      puts 'Cleanup artifacts'
      FileUtils::remove_entry_secure("#{ENV['CC_BUILD_ARTIFACTS']}/driver", :force => true)
      FileUtils::remove_entry_secure("#{ENV['CC_BUILD_ARTIFACTS']}/sut_qt", :force => true)
      FileUtils::remove_entry_secure("#{ENV['CC_BUILD_ARTIFACTS']}/tests", :force => true)
      FileUtils::remove_entry_secure("#{ENV['CC_BUILD_ARTIFACTS']}/tests/test/feature_xml", :force => true)

    ensure
      Dir.chdir(current_dir)
    end

  end
end

def collect_artifacts()
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

  run_tests( "linux", "tdrunner cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_linux --tdriver_parameters custom_parameters.xml" )

end

task :doc_meego do 

  run_tests( "meego", "tdrunner cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_meego --tdriver_parameters custom_parameters.xml" )

end

task :doc_windows do 

  run_tests( "windows", "tdrunner cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_windows --tdriver_parameters custom_parameters.xml" )

end

task :doc_symbian do 
  result=run_tests( "symbian", "tdrunner cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_symbian --tdriver_parameters custom_parameters.xml" )
  puts "Feature tests executed"
  collect_artifacts()
  raise "Feature tests failed" if (result != true) or ($? != 0)
  exit(0)
end


desc "Task for executing smoke tests"
task :execute_smoke do

  puts "#########################################################"
  puts "### Executing smoke tests                            ####"
  puts "#########################################################"
  begin
    current_dir=Dir.pwd
    Dir.chdir('test/tc_testapp')
    cmd = "ruby tc_testapp.rb --tdriver_parameters #{current_dir}/test/custom_parameters.xml"
    failure = system(cmd)
    
	
  ensure
    Dir.chdir("../../")
    if ENV['CC_BUILD_ARTIFACTS']    
      #Copy results to build artifacts
      Dir.foreach("#{Dir.pwd}/test/tc_testapp/tdriver_reports") do |entry|
        if entry.include?('test_run')
          FileUtils.cp_r "#{Dir.pwd}/test/tc_testapp/tdriver_reports/#{entry}", "#{ENV['CC_BUILD_ARTIFACTS']}/#{entry}"
          FileUtils::remove_entry_secure("#{Dir.pwd}/test/tc_testapp/tdriver_reports/#{entry}", :force => true)
        end
      end
    end    

  end
  raise "Smoke tests failed" if (failure != true) or ($? != 0) 
  failure
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
    result=run_tests( "windows", "tdrunner cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_windows --tdriver_parameters custom_parameters.xml" )
  else
    result=run_tests( "linux", "tdrunner cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_linux --tdriver_parameters custom_parameters.xml" )
  end    
  puts "Feature tests executed"
  collect_artifacts()
  generate_sut_qt_api_doc()
  raise "Feature tests failed" if (result != true) or ($? != 0)
  exit(0)
end


