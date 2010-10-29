@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap
  As a test script writer
  I want to use tap method to simulate user tapping or clicking an object,
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing tap method without arguments
    Given I launch application "calculator"
    When I execute "@app.Button(:name => 'oneButton').tap"
    Then The calculator display says "1"

  Scenario: Testing tap method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap(tap_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap method with optional argument 'interval' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap(tap_params, interval)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap(tap_params, interval, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

