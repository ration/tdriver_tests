Feature: MobyBehaviour::QT::Widget#press
  As a test scripter writer
  I want to use press method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing press method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].press()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing press method with optional argument 'tap_count' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].press(tap_count)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing press method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].press(tap_count, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

