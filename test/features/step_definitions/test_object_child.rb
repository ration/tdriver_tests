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

Then "a test object is found by child" do
  raise @__exception if @__exception != nil
  verify_true(0, 'Test object was not found by child method' ) { | | $testobj.class == MobyBase::TestObject }
end

Then "another test object with the same rule should be equal" do
  raise @__exception if @__exception != nil
  verify_equal($testobj ,30, "Two child objects with the same rule should be equal") {@app.child(:text => 'MC')}
end

  