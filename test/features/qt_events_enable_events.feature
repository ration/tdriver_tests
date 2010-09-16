Feature: TestObject::enable_events (Rename this to be more descriptive)
  As a test scripter writer
  I want to use enable_events method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Events behaviour

  Scenario: Testing enable_events method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].enable_events()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing enable_events method with optional argument 'filter_array' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].enable_events(filter_array)"
    Then [ADD_YOUR_VERIFICATION_HERE]

