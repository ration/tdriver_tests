Feature: TestObject::fixture (Rename this to be more descriptive)
  As a test scripter writer
  I want to use fixture method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Fixture behaviour

  Scenario: Testing fixture method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].fixture(fixture_name, fixture_method)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing fixture method with optional argument 'parameters_hash' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].fixture(fixture_name, fixture_method, parameters_hash)"
    Then [ADD_YOUR_VERIFICATION_HERE]

