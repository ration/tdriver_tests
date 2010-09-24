Feature: MobyBehaviour::QT::Webkit#scroll
  As a test scripter writer
  I want to use scroll method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: Testing scroll method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].scroll()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing scroll method with optional argument 'dx' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].scroll(dx)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing scroll method with optional argument 'dy' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].scroll(dx, dy)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing scroll method with optional argument 'tap' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].scroll(dx, dy, tap)"
    Then [ADD_YOUR_VERIFICATION_HERE]

