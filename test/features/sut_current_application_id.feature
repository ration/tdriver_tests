@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#current_application_id=
  As a test scripter writer
  I want to use current_application_id attribute to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing current_application_id attribute (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].current_application_id"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing current_application_id= attribute (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].current_application_id="
    Then [ADD_YOUR_VERIFICATION_HERE]

