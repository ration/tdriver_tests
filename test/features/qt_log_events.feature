Feature: MobyBehaviour::QT::ConfigureBehaviour#log_events
  As a test script writer
  I want to log events into the logs in the application 
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

@qt_windows
  Scenario: Clear the log file for sut
    Given I have default sut
    And I launch application "calculator"
    And I enable logging on the application
    And I clear the log file for the app
    Then I execute "@app.log_events('MouseRelease')"
    And I perform some taps on the app
    And I make sure MouseRelease events are in the log C:/logs/testability/calculator.log

@qt_linux 
  Scenario: Clear the log file for sut
    Given I have default sut
    And I launch application "calculator"
    And I enable logging on the application
    And I clear the log file for the app
    Then I execute "@app.log_events('MouseRelease')"
    And I perform some taps on the app
    And I make sure MouseRelease events are in the log /logs/testability/calculator.log
