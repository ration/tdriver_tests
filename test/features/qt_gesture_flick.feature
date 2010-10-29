@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#flick
  As a test script writer
  I want to use flick method to move objects in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: The flick method can be used by defining a direction to flick
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.flick( :Left )"
    Then the Node has moved left

  Scenario: The used button can be defined
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.flick( :Right, :Left )"
    Then the Node has moved right

  Scenario: The 'optional_params' argument can be used to set :use_tap_screen
    Given I launch application "testapp" as "@app"
	And I know the Node initial location
    When I execute "@app.Node.flick( :Up, :Left, { :use_tap_screen => true } )"
    Then the Node has moved up
	
