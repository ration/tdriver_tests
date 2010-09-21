Feature: MobyBehaviour::SUT#parameter
  As a test scripter writer
  I want to use parameter method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing parameter method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].parameter()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing parameter method with optional argument 'arguments' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].parameter(arguments)"
    Then [ADD_YOUR_VERIFICATION_HERE]

