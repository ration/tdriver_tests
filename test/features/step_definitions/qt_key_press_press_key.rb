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


# The testapp application example must be compiled and in PATH for this test to work
# default_sut parameter must be defined in tdriver_parameters.xml, or
# TDRIVER_DEFAULT_SUT environment variable must be set
# Author: Ari Hyttinen
# Date: 28.09.2010
# Purpose: Tests TDriver



Then /^testapp nonModalPopup button is not visible on screen$/ do
  verify_equal("false", 2, "nonModalPopup button should not be visible") { @app.Control( :name => 'nonModalPopup' ).attribute('visibleOnScreen') }
end

Then /^testapp nonModalPopup button is visible on screen$/ do
  verify_equal("true", 2, "nonModalPopup button should be visible") { @app.Control( :name => 'nonModalPopup' ).attribute('visibleOnScreen') }
end
