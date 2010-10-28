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

Then "I get a Hash containing all sut parameters" do
  raise @__exception if @__exception != nil
  verify_true(0, "Parameter hash was not retreived successfully") { $parameter_hash.class == MobyUtil::ParameterHash }
end

Then "return value \"$variable\" is kind of \"$type\"" do | $variable, $type |
  raise @__exception if @__exception != nil
  verify_true(0, "Parameter hash was not retreived successfully") { eval("#{ $variable }.class.to_s == '#{ $type }'") }
end


And "I set new sut parameter \"$parameter\" to \"$value\"" do |$parameter, $value|
  raise @__exception if @__exception != nil
  eval("@sut.parameter[\"#{$parameter}\"]=\"#{$value}\"")
end

Then "parameter \"$parameter\" should have value \"$value\"" do |$parameter, $value|
  raise @__exception if @__exception != nil
  verify_true(0, "Parameter hash was not set successfully") { MobyUtil::Parameter[ @sut.id ][ $parameter ] == $value }
end

