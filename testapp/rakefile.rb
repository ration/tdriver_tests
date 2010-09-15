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



@__release_mode = ENV['rel_mode']
@__release_mode = 'minor' if @__release_mode == nil
  
# version information
def read_version
	version = "0"
	File.open(Dir.getwd << '/debian/changelog') do |file|
		
		line = file.gets
		arr = line.split(')')
		arr = arr[0].split('(')
		version = arr[1]
	end
	
	if(@__release_mode == 'release')
		return version
	else
		return version + "~" + Time.now.strftime("%Y%m%d%H%M%S")   
	end
end

@__tas_revision = read_version
puts "version " << @__tas_revision

desc "Task for cruise control"
task :cruise => ['build_testapp', 'run_feature_tests', 'pack_testapp'] do
	exit(0)
end

desc "Task for building the example QT application(s)"
task :build_testapp do

  puts "#########################################################"
  puts "### Building testapp                                 ####"
  puts "#########################################################"

  if /win/ =~ RUBY_PLATFORM

    stdOut = `make distclean`
    stdOut = `qmake -win32 testapp.pro`
    stdOut = `make release`
    stdOut = `make install`
  else
    cmd = "make distclean;qmake testapp.pro; make; echo \"testability\" | sudo -S make install"
    stdOut = system(cmd)
  end
	puts "testapp built"
end

desc "Task for packing the testapp"
task :pack_testapp do

  orig_dir = Dir.getwd

  puts "#########################################################"
  puts "### Packing testapp source code                      ####"
  puts "#########################################################"


  if /win/ =~ RUBY_PLATFORM

		cmd = "git archive --format=zip HEAD > /qttas/export/MATTI_testapp_#{@__tas_revision}.zip"    		
    system(cmd)   
  else
  
    cmd = "git archive --format=zip HEAD > /qttas/export/MATTI_testapp_#{@__tas_revision}.gz"    
    system(cmd)
  end
	
	puts "testapp packed"
end

desc "Task for running feature tests"
task :run_feature_tests do

  orig_dir = Dir.getwd

  puts "#########################################################"
  puts "### Running feature tests                            ####"
  puts "#########################################################"

	Dir.chdir('tsrc')
  cmd = "cucumber features -f MattiReport::CucumberFormatter"
  failure = system(cmd)
  raise "feature tests failed" if (failure != true) or ($? != 0)
	Dir.chdir(orig_dir)
	
	puts "testapp features tested"
	
end