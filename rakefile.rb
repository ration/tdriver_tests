require 'fileutils'

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
    system( command_line )

  ensure

    Dir.chdir("..")

  end

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



