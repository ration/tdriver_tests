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

Then("I cannot get events for $name") do |name| 
  verify_not(5){@app.Button(:name => name).get_events()}
end

Then("Tap button $name") do |name|
  @app.Button( :name => name ).tap
end

Then("the results of $name should contain $event_list events") do |name, event_list|
  results = @app.Button(:name => name).get_events()
  events = event_list.split(',')
  events.each{|event| verify_equal(true,1){results.include?(event)}}
end

Then("the results of $name should not contain $event_list events") do |name, event_list|
  results = @app.Button(:name => name).get_events()
  events = event_list.split(',')
  events.each{|event| verify_equal(false,1){results.include?(event)}}
end

Then("I start listening to events on button $name") do |name|
  @app.Button(:name => name).enable_events('ALL')
end
