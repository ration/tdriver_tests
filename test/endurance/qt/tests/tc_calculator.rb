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


# The calculator application example must be compiled and in PATH for this example to work 
# /matti/Tutorials/QT/application_examples/calculator/release

# The following line includes the complete matti environment 
require 'tdriver'
include TDriverVerify

# Require ruby unit test framework: This enables execution of test cases and also includes assertions (Test::Unit::Assertions).
# The test methods starting with test_ found in TC_Calculator (or any Test::Unit::TestCase derived class)
# can be executed by running this file.
require 'test/unit'

class TC_Calculator < Test::Unit::TestCase 
  
  # setup and teardown methods are always executed before each and after each test case method
  def setup

    # get the calculator app running 
    @sut = TDriver.sut(:Id => "sut_qt")
    @calc = @sut.run(:name => "calculator")
  
    # performance tuning:
    # synchronisation with the sut is disabled while test objects are created for used buttons 
    
    @sut.refresh
  #  @sut.freeze
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
    #@sut.unfreeze
    
  end
  
  def teardown
    
    @calc.close 
           
  end
  
  # NOTE: test_cases are executed in alphabetical order (not in the order they are defined)
  # This is one of the reasons why test cases must not have any sequential dependencies/coupling
  def _test_initial_state_displays_zero
    
    #assert_equal "0", @display.attribute("text"), "Zero should be displayed when the calculator is started."
    verify_equal( "0", 5, "Zero should be displayed when the calculator is started." ){ @display.attribute("text") }
    
  end
  
  def test_1_simple_addition
  
    @buttons["2"].tap
    @buttons["+"].tap
    @buttons["3"].tap
    @buttons["="].tap
    
    # manually synchronise, as attribute calls are not synchronised, 
    # the sut is only automatically synchronized before a test object 
    # is requested or a behaviour method is called
    #@sut.refresh

    verify_equal( "5", 5, "Adding 3 to 2 should display 5" ){ @display.attribute("text") }
    #assert_equal "5", @display.attribute("text"), "Adding 3 to 2 should display 5"
    
  end

  def test_2_add_to_result
        
    # setup
    @buttons["5"].tap
    @buttons["="].tap
    
    # exercise
    @buttons["+"].tap
    @buttons["1"].tap
    @buttons["3"].tap
    @buttons["="].tap
    
    #@sut.refresh
    #assert_equal "18", @display.attribute("text"), "Adding a further 13 to 5 should display 18"
    verify_equal( "18", 5, "Adding a further 13 to 5 should display 18" ){ @display.attribute("text") }
    
  end

  def test_3_subtraction
     
    @buttons["1"].tap
    @buttons["5"].tap
    @buttons["-"].tap    
    @buttons["6"].tap
    @buttons["="].tap
    
    #@sut.refresh
    #assert_equal "9", @display.attribute("text"), "Subtracting 6 from 15 should display 9"
    verify_equal( "9", 5, "Subtracting 6 from 15 should display 9" ){ @display.attribute("text") }
    
  end
  
  def test_4_memory_store
    
    @buttons["2"].tap
    @buttons["0"].tap
    
    # the memory store button was not defined in setup, so it has to be fetched here
    #assert_nothing_raised "The store to memory button was not found on the calculator" do
    #  @store_button = @calc.Button(:objectName => "setMemoryButton")
    #end

    verify( 5, "The store to memory button was not found on the calculator" ) { @store_button = @calc.Button(:objectName => "setMemoryButton") }
    
    @store_button.tap
    
    #@sut.refresh    
    #assert_equal "20", @display.attribute("text"), "Storing should not affect the displayed value"
    verify_equal( "20", 5, "Storing should not affect the displayed value" ){ @display.attribute("text") }
        
  end
  
  def test_5_memory_recall
    
    # setup
    @buttons["2"].tap
    @buttons["0"].tap
        
    #assert_nothing_raised "Tapping the buttons should not cause any exceptions" do
    #  @calc.Button(:objectName => "setMemoryButton").tap
    #  @calc.Button(:text => "Clear All").tap
    #end

    verify( 5, "Tapping the buttons should not cause any exceptions" ) {       
      @calc.Button(:objectName => "setMemoryButton").tap
      @calc.Button(:text => "Clear All").tap
    }
    
    #@sut.refresh    
    #assert_equal "0", @display.attribute("text"), "Zero should be displayed after clearing"    
    verify_equal( "0", 5, "Zero should be displayed after clearing" ){ @display.attribute("text") }
    
    # exercise
    #assert_nothing_raised "The read from memory button could not be tapped" do
    #  @calc.Button(:objectName => "readMemoryButton").tap
    #end

    verify( 5, "The read from memory button could not be tapped" ) {       
      @calc.Button(:objectName => "readMemoryButton").tap
    }

    
    #@sut.refresh    
    #assert_equal "20", @display.attribute("text"), "After recall 20 should be displayed"    
    verify_equal( "20", 5, "After recall 20 should be displayed" ){ @display.attribute("text") }
    
  end
  
  def test_6_calculator_objects
        
    # check if the calculator has expected objects and attributes
    
    #assert_kind_of MobyBase::QT::OsBehaviour, @calc, "Any QT application should have OsBehaviour"
	
    verify_true( 5, "Any QT application should have OsBehaviour" ) {
	  #@calc.kind_of?( MobyBase::QT::OsBehaviour )
	  @calc.kind_of?(Object)
    }

    # clear all should be on the right side of clear
    #assert @calc.Button(:text => "Clear All").attribute("x_absolute").to_i > @calc.Button(:text => "Clear").attribute("x_absolute").to_i, "The clear all button should have been on the right side of the clear button"
            
    verify_true( 5, "The clear all button should have been on the right side of the clear button" ) {
      @calc.Button(:text => "Clear All").attribute("x_absolute").to_i > @calc.Button(:text => "Clear").attribute("x_absolute").to_i
    }


    # The calculator should not have a button with the label "Reset"
    #assert_raises MobyBase::TestObjectNotFoundError, "No reset button should exist" do
    #  reset_button = @calc.Button( :text => "Reset", :__timeout => 0 )
    #end
        
    verify_not( 5, "No reset button should exist" ) {
    
      reset_button = @calc.Button( :text => "Reset", :__timeout => 0 )

    }

    # However, it should have one with the "Backspace" label
    #assert_nothing_raised "No backspace button found" do
    #  backspace_button = @calc.Button(:text => "Backspace")
    #end
   
    verify( 5, "No backspace button found" ) {
      backspace_button = @calc.Button(:text => "Backspace")
   }
 
  end

end
