Feature: TestObject::dump_count (Rename this to be more descriptive)
  As a test scripter writer
  I want to use dump_count attribute to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing dump_count attribute (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].dump_count"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing dump_count= attribute (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].dump_count="
    Then [ADD_YOUR_VERIFICATION_HERE]

