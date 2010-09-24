Feature: MobyBehaviour::TestObject#children
  As a test scripter writer
  I want to use children method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing children method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].children(attributes)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing children method with optional argument 'find_all_children' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].children(attributes, find_all_children)"
    Then [ADD_YOUR_VERIFICATION_HERE]

