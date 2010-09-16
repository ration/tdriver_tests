Feature: TestObject::application (Rename this to be more descriptive)
  As a test scripter writer
  I want to use application method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing application method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].application()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing application method with optional argument 'attributes' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].application(attributes)"
    Then [ADD_YOUR_VERIFICATION_HERE]

