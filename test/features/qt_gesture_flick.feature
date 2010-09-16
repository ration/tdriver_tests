Feature: TestObject::flick (Rename this to be more descriptive)
  As a test scripter writer
  I want to use flick method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing flick method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].flick(direction)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing flick method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].flick(direction, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing flick method with optional argument 'optional_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].flick(direction, button, optional_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

