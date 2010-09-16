Feature: TestObject::gesture_to_object (Rename this to be more descriptive)
  As a test scripter writer
  I want to use gesture_to_object method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing gesture_to_object method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_to_object(target_object, duration)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_to_object method with optional argument 'optional_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_to_object(target_object, duration, optional_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_to_object method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_to_object(target_object, duration, optional_params, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_to_object method with optional argument 'isDrag' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_to_object(target_object, duration, optional_params, button, isDrag)"
    Then [ADD_YOUR_VERIFICATION_HERE]

