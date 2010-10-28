task :default do

  abort("Supported tasks: doc")

end

task :doc_linux do 

  puts "Executing documentation linux feature tests...\n"

  begin

    Dir.chdir("test")

    system("cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags ~@qt_windows,~@qt_symbian ")

  ensure

    Dir.chdir("..")

  end

end

task :doc_windows do 

  puts "Executing documentation windows feature tests...\n"

  begin

    Dir.chdir("test")

    system("cucumber features -f TDriverDocument::CucumberReport -f TDriverReport::CucumberReporter --out log.log --tags ~@qt_linux,~@qt_symbian ")

  ensure

    Dir.chdir("..")

  end

end



