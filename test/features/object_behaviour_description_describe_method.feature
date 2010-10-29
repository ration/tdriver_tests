Feature: MobyBehaviour::ObjectBehaviourDescription#describe_method
  As a test scripter writer
  I want to use describe_method method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::ObjectBehaviourDescription behaviour

  Scenario: Testing describe_method method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].describe_method(method_name)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing describe_method method with optional argument 'print' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].describe_method(method_name, print)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing describe_method method with optional argument 'return_result' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].describe_method(method_name, print, return_result)"
    Then [ADD_YOUR_VERIFICATION_HERE]

