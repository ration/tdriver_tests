@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObjectSynchronization#wait_child
  As a test scripter writer
  I want to use wait_child method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::TestObjectSynchronization behaviour

  Scenario: Testing wait_child method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].wait_child"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing wait_child method with optional argument 'attributes' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].wait_child(attributes)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing wait_child method with optional argument 'timeout_secs' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].wait_child(attributes, timeout_secs)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing wait_child method with optional argument 'retry_interval' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].wait_child(attributes, timeout_secs, retry_interval)"
    Then [ADD_YOUR_VERIFICATION_HERE]

