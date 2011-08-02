

Feature: MobyBehaviour::QT::SUT#log_process_mem_start
  As a test scripter writer
  I want to use log_process_mem_start method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing log_process_mem_start method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_process_mem_start(thread_name)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing log_process_mem_start method with optional argument 'file_name' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_process_mem_start(thread_name, file_name)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing log_process_mem_start method with optional argument 'timestamp_type' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_process_mem_start(thread_name, file_name, timestamp_type)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing log_process_mem_start method with optional argument 'interval_s' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].log_process_mem_start(thread_name, file_name, timestamp_type, interval_s)"
    Then [ADD_YOUR_VERIFICATION_HERE]

