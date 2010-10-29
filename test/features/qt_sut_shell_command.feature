Feature: MobyBehaviour::QT::SUT#shell_command
  As a test scripter writer
  I want to use shell_command method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing shell_command method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].shell_command(pid)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing shell_command method with optional argument 'param' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].shell_command(pid, param)"
    Then [ADD_YOUR_VERIFICATION_HERE]

