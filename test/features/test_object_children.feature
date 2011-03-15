@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#children
  As a test scripter writer
  I want to use children method to retrieve all children test objects that meet the given criteriain in calculator
  so that I can test the MobyBehaviour::TestObject behaviour
		
  Scenario: Retrieve all child test objects with certain attribute matching
    Given I launch application "calculator" as "@app"
    When I execute "$test_objs = @app.children(:toolButtonStyle => 'ToolButtonIconOnly')"
    Then an array of test objects of size "31" is returned
  
  Scenario: Fetch only immediate children matching
    Given I launch application "calculator" as "@app"
    When I execute "$test_objs = @app.children({}, false)"
    Then an array of test objects of size "1" is returned
  
  Scenario: Retrieving the test objects which text attribute matches with given regular expression
    Given I launch application "calculator" as "@app"
    When I execute "@app.children(:text => /^(1|2|3|5)$/)"
    Then exception is not thrown
    And verify "@app.children(:text => /^(1|2|3|5)$/).count == 4"

  Scenario: Retrieving the test objects which name matches with given regular expression
    Given I launch application "calculator" as "@app"
    When I execute "@app.children(:name => /^(oneButton|fiveButton|nineButton)$/)"
    Then exception is not thrown
    And verify "@app.children(:name => /^(oneButton|fiveButton|nineButton)$/).count == 3"

