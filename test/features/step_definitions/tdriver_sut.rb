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


# Author: Mika Leiman
# Date: 16.12.2010
# Purpose: Tests TDriver


require 'tdriver'
include TDriverVerify


Then /^the amount of sent data is retrieved$/ do
  verify_true(0,"Sent data should have been retrieved"){@sent_data>0}
end

Then /^the amount of received data is retrieved$/ do
  verify_true(0,"Received data should have been retrieved"){@received_data>0}
end
