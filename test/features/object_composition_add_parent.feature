Feature: TestObject::add_parent (Rename this to be more descriptive)
  As a test scripter writer
  I want to use add_parent method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::ObjectComposition behaviour

  Scenario: Testing add_parent method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].add_parent(parent_object)"
    Then [ADD_YOUR_VERIFICATION_HERE]

