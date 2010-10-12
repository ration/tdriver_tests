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
# Date: 15.09.2010
# Purpose: Tests TDriver


Before do
	@testobj = nil
end

Then /^a test object is found by find$/ do
  raise @__exception if @__exception != nil
  verify_true(0, 'Test object was not found when it should have been' ) { | | @testobj.class == MobyBase::TestObject }
end

#TDriver.sut( :Id => 'sut_qt' ).find