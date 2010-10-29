@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::ConfigureBehaviour#set_log_level
  As a test script writer
  I want to change the log level in the target logs
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

  Scenario: Set log level to INFO on the application
    Given I have default sut
    And I launch application "calculator"
    And I disable logging on the application
    And I delete file /logs/testability/calculator.log
    And file /logs/testability/calculator.log should not exist
    Then I execute "@app.set_log_level(:INFO)"
    And I enable logging on the application
    And I get current application
    And file /logs/testability/calculator.log should exist
    And log file /logs/testability/calculator.log should not contain DEBUG messages

  Scenario: Set log level to INFO on the sut
    Given I have default sut
    And I disable logging on the sut
    And I delete file /logs/testability/qttasserver.log
    And file /logs/testability/qttasserver.log should not exist
    Then I execute "@sut.set_log_level(:INFO)"
    And I enable logging on the sut
    And I get current application
    And file /logs/testability/qttasserver.log should exist
    And log file /logs/testability/qttasserver.log should not contain DEBUG messages


