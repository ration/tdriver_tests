Feature: MobyBehaviour::QT::SUT#tap_screen
  As a test scripter writer
  I want to use tap_screen method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing tap_screen method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_screen(x, y)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_screen method with optional argument 'time_to_hold' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_screen(x, y, time_to_hold)"
    Then [ADD_YOUR_VERIFICATION_HERE]

