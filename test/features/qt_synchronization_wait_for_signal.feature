Feature: MobyBehaviour::QT::Synchronization#wait_for_signal
  As a test scripter writer
  I want to use wait_for_signal method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Synchronization behaviour

  Scenario: Testing wait_for_signal method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].wait_for_signal(signal_timeout, signal_name)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing wait_for_signal method with optional argument 'block' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].wait_for_signal(signal_timeout, signal_name, block)"
    Then [ADD_YOUR_VERIFICATION_HERE]

