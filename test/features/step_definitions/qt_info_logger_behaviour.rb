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


# Common step definitions to be used in feature testing of TDriver
# Author: Mika Leiman
# Date: 26.10.2010
# Purpose: Steps used to test info logger behaviour


require 'tdriver'
include TDriverVerify

Then /^I can read the log data from "([^\"]*)"$/ do | data |

  verify_true(0,"log data was not retrieved"){ 

    eval( data ).logData.attribute('entryCount').to_i > 0

  }  
  
end

Then "I can read the cpu log data" do
  count = @cpu_log_data.logData.attribute('entryCount').to_i
  verify_true(0,"cpu log data retrieved"){count>0}  
end

Then "I can read the gpu log data" do 
  count = @gpu_log_data.logData.attribute('entryCount').to_i
  verify_true(0,"gpu log data retrieved"){count>0}
end

Then "I can read the mem log data" do
  count = @mem_log_data.logData.attribute('entryCount').to_i
  verify_true(0,"gpu log data retrieved"){count>0}
end
