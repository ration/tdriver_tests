Feature: TestObject::stop_gpu_log (Rename this to be more descriptive)
  As a test scripter writer
  I want to use stop_gpu_log method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

  Scenario: Testing stop_gpu_log method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].stop_gpu_log()"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing stop_gpu_log method with optional argument 'params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].stop_gpu_log(params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

