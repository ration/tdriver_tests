@no_doc @nodoc
Feature: MobyBehaviour::QT::Webkit#execute_javascript_query
  As a test scripter writer
  I want to use execute_javascript_query method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: Testing execute_javascript_query method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].execute_javascript_query(java_script)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing execute_javascript_query method with optional argument 'locator_query' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].execute_javascript_query(java_script, locator_query)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing execute_javascript_query method with optional argument 'index' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].execute_javascript_query(java_script, locator_query, index)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing execute_javascript_query method with optional argument 'webframe_id' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].execute_javascript_query(java_script, locator_query, index, webframe_id)"
    Then [ADD_YOUR_VERIFICATION_HERE]

