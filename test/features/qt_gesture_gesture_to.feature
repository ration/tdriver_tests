Feature: MobyBehaviour::QT::Gesture#gesture_to
  As a test scripter writer
  I want to use gesture_to method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing gesture_to method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_to(x, y, speed)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_to method with optional argument 'optional_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_to(x, y, speed, optional_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_to method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_to(x, y, speed, optional_params, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_to method with optional argument 'isDrag' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_to(x, y, speed, optional_params, button, isDrag)"
    Then [ADD_YOUR_VERIFICATION_HERE]

