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

require 'tdriver'
include TDriverVerify

Before do
  $ErrorMessage=""
end

After do
  if @sut
	@sut.set_log_folder('/logs/testability')
	@sut.set_log_level(:DEBUG)
	@sut.log_to_qdebug(false)
	@sut.log_qdebug(false)
	@sut.set_log_size(10000)
	@sut.enable_logger
  end
end

Then("I clear the log file for the app") do 
  @app.clear_log
end

Then("I clear the log file for the sut") do 
  @sut.clear_log
end

Then("I delete file $name") do |name|
  File.delete(name) if File.exist?(name)
end

Then("I get current application") do 
  @sut.application
end

Then("I disable logging on the application") do 
  @app.disable_logger
end

Then("I disable logging on the sut") do 
  @sut.disable_logger
end

Then("I enable logging on the sut") do
  @sut.enable_logger
end

Then("I enable logging on the application") do
  @app.enable_logger
end

Then("file $name should exist") do |name|
  verify_equal(true,5){File.exist?(name.to_s)}
end

Then("file $name should not exist") do |name|
  verify_equal(false,5){File.exist?(name)}
end

Then("log file $file should not contain $level messages") do |file, level|
  File.open(file).each_line do |line|
	line.to_s.include?(level).should == false
  end.close
end

Then("change sut log folder $name") do |name|
  @sut.set_log_folder(name)
  @sut.set_log_size(100000)
end

Then("I make sure the file size of $name is smaller than stored file size") do |name|
  @sut.freeze
  puts File.size(name).to_s
  verify_true(2, "File must be smaller than " + @size.to_s){File.size(name) < @size.to_i}
  @sut.unfreeze
end

Then("file size of $name is smaller than $size") do |name, size|
  @sut.freeze
  verify_true(2, "File must be smaller than " + name.to_s){File.size(name) <= size.to_i}
  @sut.unfreeze
end

Then("I store the file size of $name") do |name|
  @size = File.size(name)
end

Then("I perform some taps on the app") do
  @app.Button( :name => 'fourButton' ).tap
  @app.Button( :name => 'fiveButton' ).tap
end

Then("I make sure $event events are in the log $name") do |event, name|
  found = false
  File.open(name).each_line do |line|
	found = true if line.to_s.include?(event)	
  end.close
  verify_true(1,"Must be true"){found}
end

Then("I start logging $event events for app") do |event|
  @app.log_events(event)
end
