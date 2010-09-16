Feature: TestObject::find_on_screen (Rename this to be more descriptive)
  As a test scripter writer
  I want to use find_on_screen method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::ScreenCapture behaviour

  Scenario: Testing find_on_screen method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].find_on_screen(image_or_path)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing find_on_screen method with optional argument 'tolerance' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].find_on_screen(image_or_path, tolerance)"
    Then [ADD_YOUR_VERIFICATION_HERE]

