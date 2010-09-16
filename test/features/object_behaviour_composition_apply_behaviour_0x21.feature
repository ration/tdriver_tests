Feature: TestObject::apply_behaviour! (Rename this to be more descriptive)
  As a test scripter writer
  I want to use apply_behaviour! method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::ObjectBehaviourComposition behaviour

  Scenario: Testing apply_behaviour! method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].apply_behaviour!(rules)"
    Then [ADD_YOUR_VERIFICATION_HERE]

