@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap_up_object
  As a test scripter writer
  I want to use tap_up_object method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing tap_up_object method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_up_object(x)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_up_object method with optional argument 'y' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_up_object(x, y)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_up_object method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_up_object(x, y, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_up_object method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_up_object(x, y, button, tap_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

