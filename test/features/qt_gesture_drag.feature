@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::QT::Gesture#drag
  As a test script writer
  I want to use drag method to simulate effect of user doing drag operation,
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing drag method with required arguments direction and distance
    Given I launch application "testapp"
    Then object named "Scramble" is not visible on screen
    When I execute "@app.ControlTab( :name => 'ControlTab').drag(:Up, 10)"
    Then object named "Scramble" is visible on screen

  Scenario: Testing drag method with optional argument button (left)
    Given I launch application "testapp"
    Then object named "Scramble" is not visible on screen
    When I execute "@app.ControlTab( :name => 'ControlTab').drag(:Up, 10, :Left)"
    Then object named "Scramble" is visible on screen

  Scenario: Testing drag method with optional argument button (right)
    Given I launch application "testapp"
    Then object named "Scramble" is not visible on screen
    When I execute "@app.ControlTab( :name => 'ControlTab').drag(:Up, 10, :Right)"
    Then object named "Scramble" is not visible on screen

  Scenario: Testing drag method with optional argument 'optional_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].drag(direction, distance, button, optional_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]
