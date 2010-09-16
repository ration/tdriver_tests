Feature: TestObject::log_events (Rename this to be more descriptive)
  As a test scripter writer
  I want to use log_events method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

  Scenario: Testing log_events method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_events()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing log_events method with optional argument 'event_list' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_events(event_list)"
    Then [ADD_YOUR_VERIFICATION_HERE]

