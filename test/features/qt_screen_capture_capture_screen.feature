Feature: MobyBehaviour::QT::ScreenCapture#capture_screen
  As a test scripter writer
  I want to use capture_screen method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::ScreenCapture behaviour

  Scenario: Testing capture_screen method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].capture_screen()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing capture_screen method with optional argument 'format' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].capture_screen(format)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing capture_screen method with optional argument 'file_name' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].capture_screen(format, file_name)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing capture_screen method with optional argument 'draw' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].capture_screen(format, file_name, draw)"
    Then [ADD_YOUR_VERIFICATION_HERE]

