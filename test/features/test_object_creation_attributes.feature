Feature: TestObject::creation_attributes (Rename this to be more descriptive)
  As a test scripter writer
  I want to use creation_attributes attribute to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing creation_attributes attribute (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].creation_attributes"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing creation_attributes= attribute (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].creation_attributes="
    Then [ADD_YOUR_VERIFICATION_HERE]

