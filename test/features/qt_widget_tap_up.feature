@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap_up
  As a test scripter writer RESERVED FOR AH
  I want to use tap_up method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing tap_up method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_up()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_up method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_up(button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_up method with optional argument 'refresh' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_up(button, refresh)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing tap_up method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_up(button, refresh, tap_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

