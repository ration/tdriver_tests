Feature: TestObject::bring_to_foreground (Rename this to be more descriptive)
  As a test scripter writer
  I want to use bring_to_foreground method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Testing bring_to_foreground method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].bring_to_foreground()"
    Then [ADD_YOUR_VERIFICATION_HERE]

