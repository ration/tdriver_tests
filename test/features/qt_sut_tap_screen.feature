@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#tap_screen
  As a test scripter writer
  I want to use tap_screen method to tap the screen at specified location in testapp
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing tap_screen method with x and y coordinates
    Given I launch application "testapp" as "@app"
    And I get the coordinates for the Quit button as "$x" and "$y"
    When I execute "@__sut.tap_screen($x, $y)"
    Then exception is not thrown

  Scenario: Testing tap_screen method with optional argument 'time_to_hold'
    Given I launch application "testapp" as "@app"
    And I get the coordinates for the Quit button as "$x" and "$y"
    When I execute "@__sut.tap_screen($x, $y,2)"
    Then exception is not thrown

