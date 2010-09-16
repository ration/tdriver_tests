Feature: TestObject::tap_object (Rename this to be more descriptive)
  As a test scripter writer
  I want to use tap_object method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing tap_object method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_object(x, y)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_object method with optional argument 'tap_count' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_object(x, y, tap_count)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_object method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_object(x, y, tap_count, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_object method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_object(x, y, tap_count, button, tap_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

