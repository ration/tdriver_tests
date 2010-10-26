Feature: MobyBehaviour::QT::Application#kill
  As a test scripter writer
  I want to use kill method to kill the calculator application
  so that I can test the MobyBehaviour::QT::Application behaviour

Scenario: Testing kill method with calculator application
    Given I launch application "calculator" as "@app"
    When I execute "@app.kill()"
    Then application "calculator" is not running
