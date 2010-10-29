Feature: MobyBehaviour::QT::Gesture#gesture
  As a test script writer
  I want to use gesture method to move objects in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing gesture method with required arguments 
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.gesture( :Left, 2, 100)"
    Then the Node has moved left
	
Scenario: Testing gesture method with required arguments 2
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.gesture( :Right, 2, 100)"
    Then the Node has moved right

  Scenario: Testing gesture method with optional argument 'optional_params'
    Given I launch application "testapp" as "@app"
	And I know the Node initial location	
    When I execute "@app.Node.gesture( :Right, 2, 100, { :button => :Left, :isDrag => false } )"
    Then the Node has moved right

  Scenario: Testing gesture method with optional argument 'button'
   Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.gesture( :Up, 2, 100, { :button => :NoButton } )"
    Then the Node has not moved

  Scenario: Testing gesture method with optional argument 'isDrag'
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.gesture( :Down, 2, 100, { :isDrag => true } )"
    Then the Node has moved down
