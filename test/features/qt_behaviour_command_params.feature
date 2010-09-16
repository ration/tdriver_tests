Feature: TestObject::command_params (Rename this to be more descriptive)
  As a test scripter writer
  I want to use command_params method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Behaviour behaviour

  Scenario: Testing command_params method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].command_params(new)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing command_params method with optional argument 'command' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].command_params(new, command)"
    Then [ADD_YOUR_VERIFICATION_HERE]

