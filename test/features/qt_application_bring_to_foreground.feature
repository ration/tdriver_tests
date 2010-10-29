@qt_symbian

Feature: MobyBehaviour::QT::Application#bring_to_foreground
  As a test scripter writer
  I want to use bring_to_foreground method to brind the calculator app to the foreground
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Testing bring_to_foreground method with calculator application
    Given I launch application "calculator" as "@calculatorApp"
    Given I launch application "testapp" as "@testApp"
    When I execute "@calculatorApp.bring_to_foreground()"
    Then exception is not thrown
