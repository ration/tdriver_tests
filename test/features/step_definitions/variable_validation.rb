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


# Author: Bilkis Gargadia
# Date: 25.10.2010
# Purpose: Test TDriver methods

Then ("\"$variable_name\" is set to string \"$value\"") do |$variable_name, $value|
  raise @__exception if @__exception != nil
  verify_true(30, "#{$variable_name} does not equal #{$value}, as expected") {eval("#{$variable_name}==#{"$value"}")}
end

Then ("\"$variable_name\" is set to true") do |$variable_name|
  raise @__exception if @__exception != nil
  verify_true(30, "#{$variable_name} exepected to be true") {eval("#{$variable_name}==true")}
end

Then ("\"$variable_name\" is set to false") do |$variable_name|
  raise @__exception if @__exception != nil
  verify_true(30, "#{$variable_name} exepected to be true") {eval("#{$variable_name}==false")}
end

Then ("test objects \"$test_object1\" and \"$test_object2\" are equal") do |$test_object1,$test_object2|
  raise @__exception if @__exception != nil
  verify_equal(eval($test_object1),30, "equal") {eval($test_object2)}
end