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

require 'test/unit'

require 'tdriver'
include TDriverVerify

class TC_Calculator_launch < Test::Unit::TestCase
  
  # setup and teardown methods are always executed before each and after each test case method
  def setup
    # get the calculator app running 
    @sut = TDriver.sut(:Id => "sut_qt")    
    @calc = @sut.run(:name => "calculator")
  end

  def teardown
    @calc.close        
  end

  def test_launch_calc
  
    # performance tuning:
    # synchronisation with the sut is disabled while test objects are created for used buttons 
    
    @buttons = {
      "0" => @calc.Button(:objectName => "zeroButton"),
      "1" => @calc.Button(:objectName => "oneButton"),
      "2" => @calc.Button(:objectName => "twoButton"),
      "3" => @calc.Button(:objectName => "threeButton"),
      "4" => @calc.Button(:objectName => "fourButton"),
      "5" => @calc.Button(:objectName => "fiveButton"),
      "6" => @calc.Button(:objectName => "sixButton"),
      "7" => @calc.Button(:objectName => "sevenButton"),
      "8" => @calc.Button(:objectName => "eightButton"),
      "9" => @calc.Button(:objectName => "nineButton"),
      "+" => @calc.Button(:objectName => "plusButton"),
      "-" => @calc.Button(:objectName => "minusButton"),
      "*" => @calc.Button(:objectName => "timesButton"),
      "/" => @calc.Button(:objectName => "divisionButton"),
      "=" => @calc.Button(:objectName => "equalButton")
    }

    @display = @calc.QLineEdit(:objectName => "display")

    @buttons["1"].tap
    @buttons["+"].tap
    @buttons["2"].tap
    @buttons["="].tap    
 
    #@sut.refresh

    verify_equal( "3", 5, "After 3 should be displayed" ){ @display.attribute("text") }
    #assert_equal "3", @display.attribute("text")


  end
  
end
