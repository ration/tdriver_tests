Feature: MobyBehaviour::QT::Attribute#set_attribute
  As a test scripter writer
  I want to use set_attribute method to set object attributes in testapp
  so that I can test the MobyBehaviour::QT::Attribute behaviour

  Scenario: Testing set_attribute method with required arguments 
    Given I launch application "testapp" as "@app"
    When I execute "@app.Control( :name => 'Crash' ).set_attribute('x', '150')"
    Then the Control with name Crash has the attribute x with the value 150

  Scenario: Testing set_attribute method with optional argument 'type'
    Given I launch application "testapp" as "@app"
    When I execute "@app.Control(:name => 'Crash').set_attribute('pos', '200,250', 'QPoint')"    
	Then the Control with name Crash has the attribute x with the value 200
	And the Control with name Crash has the attribute y with the value 250

