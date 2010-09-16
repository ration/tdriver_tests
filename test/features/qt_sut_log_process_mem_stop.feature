Feature: TestObject::log_process_mem_stop (Rename this to be more descriptive)
  As a test scripter writer
  I want to use log_process_mem_stop method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing log_process_mem_stop method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_process_mem_stop(thread_name)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing log_process_mem_stop method with optional argument 'return_data' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_process_mem_stop(thread_name, return_data)"
    Then [ADD_YOUR_VERIFICATION_HERE]

