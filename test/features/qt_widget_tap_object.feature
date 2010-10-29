@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap_object
  As a test scripter writer RESERVED FOR AH
  I want to use tap_object method to tap objects at cetain coordinates in testapp application
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing tap_object method with required argument(s) (Rename this to be more descriptive)
    Given I launch application "calculator"
    When I execute "@app.Button(:text=>'1').tap_object(5, 5)"
    Then exception is not thrown
    
  Scenario: Testing tap_object method with optional argument 'tap_count' (Rename this to be more descriptive)
    Given I launch application "calculator"
    When I execute "@app.Button(:text=>'1').tap_object(5, 5, 1)"
    Then exception is not thrown

  Scenario: Testing tap_object method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application "calculator"
    When I execute "@app.Button(:text=>'1').tap_object(5, 5, 1, :Left )"
    Then exception is not thrown

  Scenario: Testing tap_object method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application "calculator"
    When I execute "@app.Button(:text=>'1').tap_object(5, 5, 1, :Left, {:use_tap_screen => 'true'})"
    Then exception is not thrown

