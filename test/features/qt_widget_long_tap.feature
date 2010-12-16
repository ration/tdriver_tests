@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#long_tap
  As a test scripter writer
  I want to use long_tap method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing long_tap method with required argument(s) (Rename this to be more descriptive)
    Given I launch application "calculator"
    When I execute "@app.Button(:text => '9').long_tap"
    Then exception is not thrown

  Scenario: Testing long_tap method with optional argument 'time' (Rename this to be more descriptive)
    Given I launch application "calculator"
    When I execute "@app.Button(:text => '9').long_tap(2)"
    Then exception is not thrown

  Scenario: Testing long_tap method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application "calculator"
    When I execute "@app.Button(:text => '9').long_tap(2, :Left)"
    Then exception is not thrown

  Scenario: Testing long_tap method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application "calculator"
    When I execute "@app.Button(:text => '9').long_tap(2, :Left, {:use_tap_screen => false})"
    Then exception is not thrown

