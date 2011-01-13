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
# Date: 12.01.2011
# Purpose: Test TDriver methods

Then "I cause testapp to crash" do
  raise @__exception if @__exception != nil
  @app.NodeView.Control(:name => 'Crash').tap
  #puts @__sut.list_crashed_apps
 end
 
Then "crashed application name is \"$crashed_app_name\"" do |crashed_app_name|
  doc = Nokogiri::XML($xml)
  verify_equal(crashed_app_name, 10){doc.xpath("//tasMessage//tasInfo//objects//object").attribute('name').to_s}
end
 