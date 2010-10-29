@qt_windows @qt_linux
Feature: MobyBehaviour::QT::ConfigureBehaviour#stop_event_logging
  As a test script writer
  I want to log stop loggin events into the logs in the application 
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

  Scenario: Clear the log file for sut
    Given I have default sut
    And I launch application "calculator"
	And I enable logging on the application
	And I clear the log file for the app
	And I start logging MouseRelease events for app
	And I perform some taps on the app
    Then I execute "@app.stop_event_logging"
	And I clear the log file for the app
	And I perform some taps on the app
	And log file /logs/testability/calculator.log should not contain MouseRelease messages
