@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#gesture_from
  As a test script writer
  I want to use gesture method to move objects in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Gesture requires that a direction, duration and distance are given.
    Given I launch application "testapp" as "@app"
	  And I know the Node initial location
    When I execute "@app.Node.gesture_from( 5, 5, 1, 20, :Left)"
    Then the Node has moved left
	
  Scenario: A similar gesture, to the right
    Given I launch application "testapp" as "@app"
	  And I know the Node initial location
    When I execute "@app.Node.gesture_from( 5, 5, 1, 20, :Right, {:button => :Left})"
    Then the Node has moved right
