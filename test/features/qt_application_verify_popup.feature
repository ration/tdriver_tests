@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Application#verify_popup
  As a test scripter writer
  I want to use verify_popup method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Testing verify_popup method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].verify_popup(class_name)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing verify_popup method with optional argument 'time_out' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].verify_popup(class_name, time_out)"
    Then [ADD_YOUR_VERIFICATION_HERE]

