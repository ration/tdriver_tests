@qt_linux @qt_windows

Feature: MobyBehaviour::SUT#translate
  As a test scripter writer
  I want to use translate method to get localised translations in testapp
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing translate method with required argument on mysql
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:text=>'Backspace')"
    Then exception is not thrown
  
  Scenario: Testing translate method with required argument on mysql
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:text=>'Backspaceasdf')"
    Then exception type of "MobyBase::TestObjectNotFoundError" is thrown
    
  Scenario: Testing translate method with required argument on mysql
    Given I launch application "calculator" as "@app"
    And I set elisis search to "true"
    When I execute "@app.Button(:text=>'Backspaceadsf')"
    Then exception is not thrown
    And I reset elisis search to "false"