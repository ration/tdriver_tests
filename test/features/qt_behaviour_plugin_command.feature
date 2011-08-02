

Feature: MobyBehaviour::QT::Behaviour#plugin_command
  As a test scripter writer
  I want to use plugin_command method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Behaviour behaviour

  Scenario: Testing plugin_command method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].plugin_command(new)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing plugin_command method with optional argument 'require_response' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].plugin_command(new, require_response)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing plugin_command method with optional argument 'command' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].plugin_command(new, require_response, command)"
    Then [ADD_YOUR_VERIFICATION_HERE]

