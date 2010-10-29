@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#gesture
  As a test script writer
  I want to use gesture method to move objects in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Gesture requires that a direction, duration and distance are given.
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.gesture( :Left, 2, 100)"
    Then the Node has moved left
	
  Scenario: A similar gesture, to the right
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.gesture( :Right, 2, 100)"
    Then the Node has moved right

  Scenario: The 'optional_params' key :button can be used to set the button used in the gesture
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.gesture( :Up, 2, 100, { :button => :NoButton } )"
    Then the Node has not moved

  Scenario: The 'optional_params' key :isDrag can be used to set whether the gesture is performed as a drag (short stops at start and end)
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.gesture( :Down, 2, 100, { :isDrag => true } )"
    Then the Node has moved down

  Scenario: Both the :button and :isDrag keys can be set
    Given I launch application "testapp" as "@app"
	And I know the Node initial location	
    When I execute "@app.Node.gesture( :Right, 2, 100, { :button => :Left, :isDrag => false } )"
    Then the Node has moved right
