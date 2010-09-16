Feature: TestObject::tap (Rename this to be more descriptive)
  As a test scripter writer
  I want to use tap method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing tap method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap()"
    Then [ADD_YOUR_VERIFICATION_HERE]

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

