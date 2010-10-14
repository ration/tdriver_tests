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
# Date: 13.10.2010
# Purpose: Test TDriver methods


Then ("the contents of \"$attributes_hash_name\" should be equal to \"$hash\"") do |$attributes_hash_name, $hash|
  raise @__exception if @__exception != nil
  verify_true(30, "#{$attributes_hash_name} does not contain expected values") { eval("#{$attributes_hash_name}==#{$hash}")}
end

And ("I change the creation attributes for Test Object \"$test_object_name\" to \"$hash\"") do |$test_object_name,$hash|
  raise @__exception if @__exception != nil
  eval("#{$test_object_name}=@app.Triangle( :name => 'Triangle1')")
  eval("#{$test_object_name}.creation_attributes=#{$hash}")
end

And ("I retrieve another instance of Test Object \"$test_obj1\" called \"$test_obj2\" using child behaviour with attributes \"$attributes\"") do |$test_obj1, $test_obj2,$attributes|
  raise @__exception if @__exception != nil
  eval("#{$test_obj2}=@app.child(#{$attributes})")
  verify_true(30, "Test Objects #{$test_obj2} and #{$test_obj1} should be the same instance") { eval("#{$test_obj2}==#{$test_obj1}")}
end
    
And ("the creation attributes of \"$test_obj1\" should be the same as \"$test_obj2\"") do |$test_obj1, $test_obj2|
  raise @__exception if @__exception != nil
  verify_true(30, "Creation attributes for  #{$test_obj2} and #{$test_obj1} should be the same") { eval("#{$test_obj2}.creation_attributes==#{$test_obj1}.creation_attributes")}
end

