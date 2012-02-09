@qt_linux @qt_windows

Feature: MobyBehaviour::QT::ConfigureBehaviour#set_log_size
  As a test script writer
  I want to set the log size in the target
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

  Scenario: Log set the log file size of qttasserver
    Given I have default sut
    And I clear the log file for the sut 
    Then I execute "@sut.set_log_size(500)"
    Given I launch application "calculator"
    And I get current application
    And file /logs/testability/qttasserver.log should exist
    And file size of /logs/testability/qttasserver.log is smaller than 500

