Feature: MobyBehaviour::QT::Application#track_popup
  As a test scripter writer
  I want to use track_popup method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Testing track_popup method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].track_popup(class_name)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing track_popup method with optional argument 'wait_time' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].track_popup(class_name, wait_time)"
    Then [ADD_YOUR_VERIFICATION_HERE]

