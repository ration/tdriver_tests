@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#move
  As a test scripter writer
  I want to use move method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing move method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].move(direction, distance)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing move method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].move(direction, distance, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing move method with optional argument 'optional_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].move(direction, distance, button, optional_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

