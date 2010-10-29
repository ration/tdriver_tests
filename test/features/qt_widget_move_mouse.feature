@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#move_mouse
  As a test scripter writer
  I want to use move_mouse method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing move_mouse method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].move_mouse()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing move_mouse method with optional argument 'move_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].move_mouse(move_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

