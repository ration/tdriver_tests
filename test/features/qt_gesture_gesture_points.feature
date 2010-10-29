@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#gesture_points
  As a test scripter writer
  I want to use gesture_points method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing gesture_points method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'mouse_details' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'press' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'release' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press, release)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press, release, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'isDrag' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press, release, button, isDrag)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'optional_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press, release, button, isDrag, optional_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

