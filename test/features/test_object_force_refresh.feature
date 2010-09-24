Feature: MobyBehaviour::TestObject#force_refresh
  As a test scripter writer
  I want to use force_refresh method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing force_refresh method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].force_refresh()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing force_refresh method with optional argument 'refresh_args' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].force_refresh(refresh_args)"
    Then [ADD_YOUR_VERIFICATION_HERE]

