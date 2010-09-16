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


# Author: Ari Hyttinen
# Date: 16.09.2010
# Purpose: Tests TDriver


require 'tdriver'
include TDriverVerify

Before do
	$ErrorMessage=""
end


Then /^suts returns a non\-empty list$/ do
  raise @__exception if @__exception != nil
  verify_true(0, "TDriver.agent_mem_usage should return class Array, but it returned class #{@tdriver_suts_list.class}") {
    @tdriver_suts_list.class == Array
  }
  verify_false(0, "TDriver.suts should return non-empty list, but it returned an empty list") {
    @tdriver_suts_list.empty?
  }
end
