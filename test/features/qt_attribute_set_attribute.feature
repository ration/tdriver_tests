@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Attribute#set_attribute
  As a test script writer
  I want to use set_attribute method to set object attributes in testapp
  so that I can test the MobyBehaviour::QT::Attribute behaviour

  Scenario: The set_attribute method deduces the attribute data type from the argument class by default.
    Given I launch application "testapp" as "@app"
    When I execute "@app.Control( :name => 'Crash' ).set_attribute('x', 150)"
    Then the Control with name Crash has the attribute Qt_x with the value 150

  Scenario: The attribute type can also be given with the optinal type argument. This is required for more complex attribute types.
    Given I launch application "testapp" as "@app"
    When I execute "@app.Control(:name => 'Crash').set_attribute('pos', '200,250', 'QPoint')"    
	Then the Control with name Crash has the attribute Qt_x with the value 200
	And the Control with name Crash has the attribute Qt_y with the value 250

