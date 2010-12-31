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

When("I tap the $name rectangle") do | name |
  @app.QDeclarativeRectangle( :name => 'Click' ).tap
end

Then("the $name will be $text") do | name, text |
  verify_equal( text, 5 ){@app.QDeclarativeText( :name => 'buttonText' ).attribute('text')}
end

Then("I tap Softkey $name") do | name |
 @app.softkey(:Text => name ).tap
end

Then("I get qt and avkon components") do
  verify(5){@app.title( :name => 'CAknTitlePane' )}
  verify(5){@app.indicator( :name => 'CAknSignalStrength' )}
  verify(5){@app.indicator( :name => 'CAknBatteryStrength' )}
  verify(5){@app.QDeclarativeRectangle( :name => 'Click' )}
  verify(5){@app.QDeclarativeRectangle( :name => 'Drag' )}
end

Then("screen rotation is $value") do | value |
  verify_equal( value, 5){@sut.application.attribute('Rotation')}
end
 
Then("I rotate screen $direction") do | direction |
  @sut.rotate_screen( direction.to_sym )
end

