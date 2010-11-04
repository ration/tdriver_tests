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
# Date: 04.11.2010
# Purpose: Test TDriver methods

Then "I obtain array of behaviour names" do
	raise @__exception if @__exception != nil
	verify_true(30, "Behaviours array is not array of behaviours names (String)") {$behaviours!=nil && $behaviours.class==Array && !$behaviours.empty? }
	$behaviours.each {|x| verify_true(0,"Behaviours array is not array of behaviour names (String)"){x.class==String}}
end

Then "I obtain array of indexes" do
	raise @__exception if @__exception != nil
	verify_true(30, "Behaviours array is not array of indexes") {$behaviours!=nil && $behaviours.class==Array && !$behaviours.empty? }
	$behaviours.each {|x| verify_true(0,"Behaviours array is not array of indexes (Fixnum)"){x.class==Fixnum}}
end