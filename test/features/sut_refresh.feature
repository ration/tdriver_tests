@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#refresh
  As a test scripter writer
  I want to use refresh method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing refresh method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].refresh"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing refresh method with optional argument 'refresh_args' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].refresh(refresh_args)"
    Then [ADD_YOUR_VERIFICATION_HERE]

