@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#move
  As a test script writer
  I want to use move method to move the pointer in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: The move method requires a direction and a distance as arguments
    Given I launch application "testapp" as "@app"
    And I know the Node initial location
    When I execute "@app.Node.move(:Left, 100)"
    Then the Node has not moved

@nodoc
  Scenario: Testing move method with optional argument 'button' to use in move
    Given I launch application "testapp" as "@app"
    And I know the Node initial location
    When I execute "@app.Node.move(:Left, 100, :Right)"
    Then the Node has not moved

@nodoc
  Scenario: Testing move method with optional argument 'optional_params'
     Given I launch application "testapp" as "@app"
    And I know the Node initial location
    When I execute "@app.Node.move(:Left, 100, :Right, {:use_tap_screen=>true})"
    Then the Node has not moved
