Feature: TestObject::drag (Rename this to be more descriptive)
  As a test scripter writer
  I want to use drag method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing drag method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].drag(direction, distance)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing drag method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].drag(direction, distance, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing drag method with optional argument 'optional_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].drag(direction, distance, button, optional_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

