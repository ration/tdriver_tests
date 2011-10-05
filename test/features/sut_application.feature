@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#application
  As a test scripter writer
  I want to use application method to get the foreground application in sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Retrieve application object
    Given I launch application "testapp" as "@app"
    When I execute "app = @__sut.application"
    Then verify "@__ret_val == @app"

  Scenario: Retrieve application object with attributes hash
    Given I launch application "testapp" as "@app"
    When I execute "app = @__sut.application(:name => 'testapp')"
    Then verify "@__ret_val == @app"
    
  Scenario: Retrieve application object with name as argument
    Given I launch application "testapp" as "@app"
    When I execute "app = @__sut.application('testapp')"
    Then verify "@__ret_val == @app"
