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


# Common step definitions to be used in feature testing of TDriver
# Author: Petri Kiiskinen
# Date: 05.10.2010
# Purpose: Common steps to be used in feature testing


require 'tdriver'
include TDriverVerify

Before do
	$ErrorMessage=""
    @__current_app = nil
    @__apps = {}
    @__ret_val = nil
    @__exception = nil
    sut = ENV['TDRIVER_DEFAULT_SUT']
    sut = TDriver.parameter[:default_sut] if !sut or sut.empty?
    @__sut = TDriver.sut(sut.to_sym) if sut != nil
end

After do
	
    @__apps.each_key do |app|

        begin
            @__apps[app].kill
        rescue Exception => e
            # nothing
        end
    end
end

Given /^I launch application "([^\"]*)"$/ do |app_name|

    app_ref = "@app"
    raise "No default sut given! Please set env variable TDRIVER_DEFAULT_SUT!" if @__sut == nil
    @__apps[app_ref] = @__sut.run( :name => app_name.to_s )
    eval(app_ref + " = @__apps[app_ref]")
    @__current_app = @__apps[app_ref] 
end


Given /^I launch application "([^\"]*)" as "([^\"]*)"$/ do |app_name, app_ref|
    
    raise "No default sut given! Please set env variable TDRIVER_SUT!" if @__sut == nil
    @__apps[app_ref] = @__sut.run( :name => app_name.to_s )
    eval(app_ref + " = @__apps[app_ref]")
    @__current_app = @__apps[app_ref] 
end

Given /^I launch application "([^\"]*)" as "([^\"]*)" on sut "([^\"]*)"$/ do |app_name, app_ref, sut_id|

    tmp_app = TDriver.sut(sut_id.to_sym).run( :name => app_name.to_s )
    eval(app_ref + " = tmp_app")
    @__apps[app_ref] = tmp_app
    @__current_app = @__apps[app_ref] 
end

When /^I execute "([^\"]*)"$/ do |script|
    begin
        @__ret_val = eval(script)
    rescue Exception => e
        @__exception = e
    end
end

Then /^The calculator display says "([^\"]*)"$/ do |result|

    raise @__exception if @__exception != nil
    verify_equal(result.to_s, 10, 'Calculator displays wrong value') { @__current_app.child(:name => 'display').attribute('text').to_s }
end

