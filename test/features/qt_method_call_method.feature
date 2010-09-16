Feature: TestObject::call_method (Rename this to be more descriptive)
  As a test scripter writer
  I want to use call_method method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Method behaviour

  Scenario: Testing call_method method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].call_method(method_name)"
    Then [ADD_YOUR_VERIFICATION_HERE]

