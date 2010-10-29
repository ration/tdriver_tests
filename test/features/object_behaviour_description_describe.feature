Feature: MobyBehaviour::ObjectBehaviourDescription#describe
  As a test scripter writer
  I want to use describe method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::ObjectBehaviourDescription behaviour

  Scenario: Testing describe method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].describe()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing describe method with optional argument 'print' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].describe(print)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing describe method with optional argument 'return_result' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].describe(print, return_result)"
    Then [ADD_YOUR_VERIFICATION_HERE]

