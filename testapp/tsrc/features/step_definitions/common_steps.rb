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


# The test application must be in path for this to work.
require 'tdriver'
#require File.join( File.expand_path( ENV['TDRIVER_HOME'] ), 'tdriver.rb' )
#require File.join( File.dirname( __FILE__ ), '../../../../tdriver/lib/tdriver.rb' )

require 'spec/expectations'
include TDriverVerify


Before do

  @sut = TDriver.sut(:Id=>'sut_qt')
   
end

After do
  begin
	@test_app.close if @test_app
	@test_app = nil
  rescue
  end
  @sut.kill_started_processes
end


Given("no active plugins") do
  verify_false(10){@sut.application.name == "testapp"}
end

Given("I run \"$app\"") do |app|
  @test_app = @sut.run(:name => app)  
end


When("\"$app_name\" starts it loads testability plugin") do |app_name|
  app = @sut.application
  verify_true(1, 'test app name') {app.name == app_name}
end

When("I close \"$app_name\" application") do |app_name|
  app = @sut.application(:name => app_name)
  app.close
  @test_app = nil 
end

When("I kill \"$app_name\" application") do |app_name|
  app = @sut.application
  app.name.should == app_name.to_s
  app.kill
  @test_app = nil 
end

Then("\"$testapp\" should no longer be running") do |app_name|
  verify_false(5, 'test app name') {@sut.application.name == app_name}
end


