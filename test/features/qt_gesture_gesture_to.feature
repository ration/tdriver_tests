@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#gesture_to
  As a test script writer
  I want to use gesture_to method to move an object to a location in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: A target coordinate point and gesture speed are required arguments for gesture_to
    Given I launch application "testapp" as "@app"
	And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.gesture_to( 300, 350, 2 )"
    Then the new absolute location of the Node is 300, 350

  Scenario: The 'optional_params' key :button can be used to set the button used in the gesture
    Given I launch application "testapp" as "@app"
	And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.gesture_to( 350, 400, 3, { :button => :Left } )"
    Then the new absolute location of the Node is 350, 400

  Scenario: The 'optional_params' key :isDrag can be used to set whether the gesture is performed as a drag (short stops at start and end)
    Given I launch application "testapp" as "@app"
	And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.gesture_to( 350, 400, 1, { :isDrag => true } )"
    Then the new absolute location of the Node is 350, 400

  Scenario: Both the :button and :isDrag keys can be set
    Given I launch application "testapp" as "@app"
	And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.gesture_to( 350, 400, 3, { :button => :Left, :isDrag => true } )"
    Then the new absolute location of the Node is 350, 400

