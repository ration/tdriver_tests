@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::QT::Application#kill
  As a test scripter writer
  I want to use kill method to kill the calculator application
  so that I can test the MobyBehaviour::QT::Application behaviour

Scenario: Testing kill method with calculator application
    Given I launch application "calculator" as "@app"
    When I execute "@app.kill()"
    Then application "calculator" is not running

@nodoc
Scenario: Testing kill method on first application, when two applications are started
    Given I launch application "calculator" as "@app1"
    And I launch application "testapp" as "@app2"
    When I execute "@app1.kill()"
    Then application "calculator" is not running

@nodoc
Scenario: Testing kill method on second application, when two applications are started
    Given I launch application "calculator" as "@app1"
    And I launch application "testapp" as "@app2"
    When I execute "@app2.kill()"
    Then application "calculator" is not running
