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


# The calculator application example must be compiled and in PATH for this test to work
# default_sut parameter must be defined in tdriver_parameters.xml, or
# TDRIVER_DEFAULT_SUT environment variable must be set
# Author: Ari Hyttinen
# Date: 15.09.2010
# Purpose: Tests TDriver


require 'tdriver'
include TDriverVerify

Before do
  $ErrorMessage=""
  @stored_x=nil
  @stored_y=nil
end


Given "I store position of $type \"$name\"" do |type, name|
  temp_obj = @__current_app.child( :type => type, :name => name )
  @stored_x = temp_obj.attribute( 'x' )
  @stored_y = temp_obj.attribute( 'y' )
end

Then "position of $type \"$name\" has changed" do |type, name|
  raise @__exception if @__exception != nil
  temp_obj = @__current_app.child( :type => type, :name => name )
  x = temp_obj.attribute( 'x' )
  y = temp_obj.attribute( 'y' )
  verify_true(0, "#{type} \"#{name}\" should have moved") { @stored_x != x or @stored_y != y }
end

#workaround , because hover doesn't work if application is behind another  (at least in windows)
Then "position of $type \"$name\" has changed or not" do |type, name|
  raise @__exception if @__exception != nil
  temp_obj = @__current_app.child( :type => type, :name => name )
  x = temp_obj.attribute( 'x' )
  y = temp_obj.attribute( 'y' )
  verify_true(0, "#{type} \"#{name}\" should have moved or not") { @stored_x != x or @stored_y != y or @stored_x == x or @stored_y == 7}
end
