@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#drag_to
  As a test script writer
  I want to use drag_to method to drag an object to an absolute location in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Basic drag_to usage with required arguments
    Given I launch application "testapp" as "@app"
	And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.drag_to(300, 350)"
    Then the new absolute location of the Node is 300, 350

  Scenario: The used button can be defined
    Given I launch application "testapp" as "@app"
	And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.drag_to(250, 200, :Left)"
    Then the new absolute location of the Node is 250, 200

  Scenario: The 'optional_params' argument can be used to set :use_tap_screen
    Given I launch application "testapp" as "@app"
	And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.drag_to(250, 200, :Left, { :use_tap_screen => true })"
    Then the new absolute location of the Node is 250, 200

