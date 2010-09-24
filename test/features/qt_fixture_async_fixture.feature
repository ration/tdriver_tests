Feature: MobyBehaviour::QT::Fixture#async_fixture
  As a test scripter writer
  I want to use async_fixture method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Fixture behaviour

  Scenario: Testing async_fixture method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].async_fixture(fixture_name, fixture_method)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing async_fixture method with optional argument 'parameters_hash' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].async_fixture(fixture_name, fixture_method, parameters_hash)"
    Then [ADD_YOUR_VERIFICATION_HERE]

