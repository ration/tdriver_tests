Feature: TestObject::long_tap_object (Rename this to be more descriptive)
  As a test scripter writer
  I want to use long_tap_object method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing long_tap_object method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].long_tap_object(x, y)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing long_tap_object method with optional argument 'time' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].long_tap_object(x, y, time)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing long_tap_object method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].long_tap_object(x, y, time, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing long_tap_object method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].long_tap_object(x, y, time, button, tap_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

