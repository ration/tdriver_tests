@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#refresh_tries=
  As a test scripter writer
  I want to use refresh_tries attribute to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing refresh_tries attribute (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].refresh_tries"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing refresh_tries= attribute (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].refresh_tries="
    Then [ADD_YOUR_VERIFICATION_HERE]

