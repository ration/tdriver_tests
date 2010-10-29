Feature: MobyBehaviour::QT::SUT#group_behaviours
  As a test scripter writer
  I want to use group_behaviours method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing group_behaviours method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].group_behaviours(interval, app)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing group_behaviours method with optional argument 'block' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].group_behaviours(interval, app, block)"
    Then [ADD_YOUR_VERIFICATION_HERE]

