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

Then ("an array of test objects of size \"$size\" is returned" ) do |$size|
  raise @__exception if @__exception != nil
  verify_equal(Array, 0, 'Returned object was not array' ) { $test_objs.class }
  verify_equal($size.to_i, 0, 'Array size is wrong' ) { $size.to_i}
  verify_equal(MobyBase::TestObject, 0, 'The returned class was wrong' ) { $test_objs[0].class }
  #verify_true(0, 'Test objects were not found by children method' ) { $test_objs.class == Array && $test_objs.size==$size.to_i && $test_objs[0].class == MobyBase::TestObject}
end
