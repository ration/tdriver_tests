Feature: MobyBehaviour::QT::Gesture#flick_to
  As a test scripter writer
  I want to use flick_to method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing flick_to method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].flick_to(x, y)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing flick_to method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].flick_to(x, y, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing flick_to method with optional argument 'optional_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].flick_to(x, y, button, optional_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

