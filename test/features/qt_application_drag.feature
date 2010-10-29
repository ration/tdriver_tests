@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Application#drag
  As a test scripter writer
  I want to use drag method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Testing drag method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].drag(start_x, start_y, end_x, end_y)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing drag method with optional argument 'duration' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].drag(start_x, start_y, end_x, end_y, duration)"
    Then [ADD_YOUR_VERIFICATION_HERE]

