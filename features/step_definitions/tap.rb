############################################################################
## 
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
## All rights reserved. 
## Contact: Nokia Corporation (testabilitydriver@nokia.com) 
## 
## This file is part of MATTI. 
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


# The calculator application example must be compiled and in PATH for this test to work
# sut_qt1, sut_qt2, sut_qt3 and sut_qt4 suts must be defined in matti_parameters.xml
# /matti/Tutorials/QT/application_examples/calculator/release
# Author: Mika Leiman
# Date: 15.5.2009
# Purpose: Tests MATTI Qt methods


require 'matti'
include MattiVerify

Before do
	$ErrorMessage=""
end

Then("I can tap \"$button_label\" button using default arguments") do |$button_label|
	verify(30, "Tapping using default arguments failed.") { @sut.application.Button(:name => $button_label.to_s).tap }
end

Then("I can tap \"$control_label\" control using default arguments") do |control_label|
	verify(30, "Tapping using default arguments failed.") { @sut.application.Control(:name => control_label.to_s).tap }
end

Then("I can not tap \"$button_label\" button") do |$button_label|
	verify_not(30, "Tapping button succeeded.") { @sut.application.Button(:name => $button_label.to_s).tap }
end

Then("I can not tap invisible \"$button_label\" button") do |$button_label|
	tap_button = @sut.application.Button(:name => $button_label.to_s)
	tap_button.set_attribute("visible", false)
	verify_not(30, "Tapping invisible button succeeded.") { tap_button.tap }
end

Then("I can not tap invisible \"$control_label\" control") do |$control_label|
	tap_button = @sut.application.Control(:name => $control_label.to_s)
	tap_button.set_attribute("visible", false)
	verify_not(30, "Tapping invisible control succeeded.") { tap_button.tap }
end

Then("the result of the button tap is $expected_value") do |$expected_value|
	verify_equal($expected_value.to_i, 30, "The result of the button tap down.") { @sut.application.QLineEdit(:objectName => "display").attribute("displayText").to_i }
end

Then("I can tap \"$button_label\" button using $mouse_button mouse button") do |$button_label, $mouse_button|
	case $mouse_button
    when "middle"
		verify(30, "Tapping with middle button failed.") { @sut.application.Button(:name => $button_label.to_s ).tap(1, :Middle) }
    when "left"
		verify(30, "Tapping with left button failed.") { @sut.application.Button(:name => $button_label.to_s ).tap(1, :Left) }
    when "right"
		verify(30, "Tapping with right button failed.") { @sut.application.Button(:name => $button_label.to_s ).tap(1, :Right) }
    when "NoButton"
		verify(30, "Tapping with no button failed.") { @sut.application.Button(:name => $button_label.to_s ).tap(1, :NoButton) }
   end
end

Then("I can tap \"$button\" control with \"$interval\" second interval \"$amount\" times") do |$button, $interval, $amount|
  app = @sut.application
  app.Menu.ControlTab.flick(:Up)
  nodes = app.NodeView.attribute('nodeCount')
  @tap_time = Time.now
  app.Control(:name => $button).tap($amount.to_i, $interval.to_i)
  dif = Time.now - @tap_time
  dif.should >= $interval.to_i
  verify_true {app.NodeView.attribute('nodeCount').to_i > $amount.to_i}
end
