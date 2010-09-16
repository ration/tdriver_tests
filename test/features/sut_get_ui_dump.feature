Feature: TestObject::get_ui_dump (Rename this to be more descriptive)
  As a test scripter writer
  I want to use get_ui_dump method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing get_ui_dump method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].get_ui_dump()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing get_ui_dump method with optional argument 'refresh_args' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].get_ui_dump(refresh_args)"
    Then [ADD_YOUR_VERIFICATION_HERE]

