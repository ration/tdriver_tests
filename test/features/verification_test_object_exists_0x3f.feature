Feature: TestObject::test_object_exists? (Rename this to be more descriptive)
  As a test scripter writer
  I want to use test_object_exists? method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::Verification behaviour

  Scenario: Testing test_object_exists? method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].test_object_exists?(type, new)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing test_object_exists? method with optional argument 'attributes' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].test_object_exists?(type, new, attributes)"
    Then [ADD_YOUR_VERIFICATION_HERE]

