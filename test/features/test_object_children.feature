@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#children
  As a test scripter writer
  I want to use children method to retrieve all children test objects that meet the given criteriain in calculator
  so that I can test the MobyBehaviour::TestObject behaviour
		
  Scenario: Testing children method with required argument
    Given I launch application "calculator" as "@app"
    When I execute "$test_objs = @app.children(:toolButtonStyle => 'ToolButtonIconOnly')"
    Then an array of test objects of size "31" is returned
  
  Scenario: Testing children method with optional argument 'find_all_children' false
    Given I launch application "calculator" as "@app"
    When I execute "$test_objs = @app.children({}, false)"
    Then an array of test objects of size "1" is returned
  
