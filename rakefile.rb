task :default do

  abort("Supported tasks: doc")

end

task :doc do 

  puts "Executing documentation feature tests...\n"

  begin

    Dir.chdir("test")

    system("cucumber features -f TDriverDocument::CucumberReport")

  ensure

    Dir.chdir("..")

  end

end

