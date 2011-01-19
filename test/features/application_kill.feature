@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::Application#kill
  As a test scripter writer
  I want to use kill method to kill the application process in calculator
  so that I can test the MobyBehaviour::Application behaviour

  Scenario: Testing kill method to kill application process
    Given I launch application "calculator" as "@app"
    When I execute "@app.kill"
    Then application "calculator" is not running