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

require 'tdriver'
include TDriverVerify

Before do
  $ErrorMessage=""
end

Then("I go to popup view") do
  @app.NodeView.flick(:Left)
end

When("I tap \"$control\" control button") do |control|
  @app.Control( :name => control ).tap
end

Then("I start to track $name") do |name|
  @app.track_popup(name)
end

Then("I verify that the popup was shown") do
  xml_as_object = @app.verify_popup('PopupItem')
  verify_equal('true',1){xml_as_object.PopupItem.attribute('visibleOnScreen')}
end 

Then("I verify that the popup data is in the xml") do
  verify_equal('true',1){@xml_object.PopupItem.attribute('visibleOnScreen')}
end
