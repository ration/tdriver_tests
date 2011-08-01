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

After do
  @__sut.parameter[:ensure_qml_visible] = 'false'
  @__sut.parameter[:ensure_visible] = 'false'
end

When("I drag the $name qml item for distance of $pixels") do | $name, $pixels |
  @app.QDeclarativeItem( :name => $name ).drag(:Up, $pixels.to_i)
end

When("qml item $name is not visible on the screen") do |$name|
  verify_equal('false', 10){@app.QDeclarativeItem( :name => $name ).attribute('visibleOnScreen')}
end

When("qml item $name is visible on the screen") do |$name|
  verify_equal('true', 10){@app.QDeclarativeItem( :name => $name ).attribute('visibleOnScreen')}
end

Then("I set $param parameter to $value") do |$param, $value|
  @__sut.parameter[$param.to_sym] = $value.to_s
  @__sut.parameter[:ensure_qml_visible] = 'true'
end

Then("I tap qml item $name") do |$name|
  @app.QDeclarativeItem( :name => $name ).tap
end

Then("qml item $name is focused") do |$name|
  verify_equal('true', 10){@app.QDeclarativeItem( :name => $name ).attribute('focus')}
end
