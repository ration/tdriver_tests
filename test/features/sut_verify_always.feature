Feature: MobyBehaviour::SUT#verify_always
  As a test scripter writer
  I want to use verify_always method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing verify_always method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].verify_always(expected)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing verify_always method with optional argument 'message' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].verify_always(expected, message)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing verify_always method with optional argument 'block' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].verify_always(expected, message, block)"
    Then [ADD_YOUR_VERIFICATION_HERE]

