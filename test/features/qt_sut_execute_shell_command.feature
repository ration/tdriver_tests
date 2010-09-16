Feature: TestObject::execute_shell_command (Rename this to be more descriptive)
  As a test scripter writer
  I want to use execute_shell_command method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing execute_shell_command method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].execute_shell_command(command)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing execute_shell_command method with optional argument 'param' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].execute_shell_command(command, param)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing execute_shell_command method with optional argument 'detached' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].execute_shell_command(command, param, detached)"
    Then [ADD_YOUR_VERIFICATION_HERE]

