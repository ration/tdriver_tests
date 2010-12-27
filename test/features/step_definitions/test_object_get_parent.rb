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
# Date: 18.10.2010
# Purpose: Test TDriver methods

And "I get the parent for \"$test_object\"" do |$test_object|
  raise @__exception if @__exception != nil
  $app_parent=eval("#{$test_object}.get_parent")
end

Then "the parent test object is \"$test_object\"" do |$test_object|
  verify_true(30, "Parent test object was not retrieved successfully") {eval("$app_parent==#{$test_object}")}	
end






