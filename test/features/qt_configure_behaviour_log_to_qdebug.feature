Feature: TestObject::log_to_qdebug (Rename this to be more descriptive)
  As a test scripter writer
  I want to use log_to_qdebug method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

  Scenario: Testing log_to_qdebug method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_to_qdebug()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing log_to_qdebug method with optional argument 'to_qdebug' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_to_qdebug(to_qdebug)"
    Then [ADD_YOUR_VERIFICATION_HERE]

