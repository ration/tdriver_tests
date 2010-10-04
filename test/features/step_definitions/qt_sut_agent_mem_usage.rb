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


# default_sut parameter must be defined in tdriver_parameters.xml, or
# TDRIVER_DEFAULT_SUT environment variable must be set
# Author: Ari Hyttinen
# Date: 16.09.2010
# Purpose: Tests TDriver



Then /^mem usage result is a positive integer$/ do
  verify_true(0, "SUT::agent_mem_usage should return class Fixnum, but it returned class #{@sut_agent_mem_usage.class}") {
    @sut_agent_mem_usage.class == Fixnum
  }
  verify_true(0, "SUT::agent_mem_usage should return positive value, but it returned #{@sut_agent_mem_usage}") {
    @sut_agent_mem_usage > 0
  }
end
