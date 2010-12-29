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

task :cruise do
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


