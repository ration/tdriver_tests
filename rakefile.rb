task :default do

  abort("Supported tasks: doc_linux, doc_windows")

end

def run_tests( name, command_line )

  puts "Executing documentation #{ name } feature tests...\n"

  begin

    Dir.chdir("test")

    system( command_line )

  ensure

    Dir.chdir("..")

  end

end

task :doc_linux do 

  run_tests( "linux", "cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_linux" )

end

task :doc_windows do 

  run_tests( "windows", "cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags @qt_windows" )

end


