Feature: TestObject::hover (Rename this to be more descriptive)
  As a test scripter writer
  I want to use hover method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Action behaviour

  Scenario: Testing hover method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].hover()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing hover method with optional argument 'refresh' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].hover(refresh)"
    Then [ADD_YOUR_VERIFICATION_HERE]

