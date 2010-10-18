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

Then "the parent object is the sut" do
  raise @__exception if @__exception != nil
  verify_true(30, "Parent test object was not retrieved successfully") {	@__ret_val==@__sut}	
end

Then "the parent object is the app" do
  raise @__exception if @__exception != nil
  verify_true(30, "Parent test object was not retrieved successfully") {	@__ret_val==@app}	
end