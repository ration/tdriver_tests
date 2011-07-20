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

Then("QLinedit has focus") do
  verify_equal('true',5){@app.QLineEdit( :name => 'display' ).attribute('focus')}
end


Then("I store dimensions for app") do 
  @width = @app.QDeclarativeView.attribute('width')
  @height = @app.QDeclarativeView.attribute('height')
end 

Then("application dimensions have switched") do 
  verify_equal(@height, 5){@app.QDeclarativeView.attribute('width')}
  verify_equal(@width, 5){@app.QDeclarativeView.attribute('height')}
end

Given /^I tap the open button in the tool bar$/ do
  @app.QToolButton( :text => 'Open' ).tap
end

Then /^I tap the native dialog "([^"]*)" button$/ do |arg1|
  @sut.fixture('dialog', 'tap_control', { :dialog_name => 'Open', :name_pattern => arg1, :class_pattern => 'Button' } )
end

Then("I clear fixture qt from parameters") do
  #puts @sut
  TDriver::Parameter[@sut.id.to_sym][:fixtures][:qt] = nil
end

Then("I create some activity") do
  3.times do
	@app.ControlTab( :name => 'ControlTab' ).flick(:Up)
	@app.ControlTab( :name => 'ControlTab' ).flick(:Down)
  end
end

Then("I stop measuring fps data") do 
  @data_array = @app.MainView( :name => 'MainView' ).stop_fps_measurement
end

Then("I verify that fps results are collected") do 
  verify_true(0){@data_array.size != 0}
  @data_array.each{|entry| verify_true(0){ entry[:value].kind_of?(Integer); entry[:time_stamp].kind_of?(String)} }
end
