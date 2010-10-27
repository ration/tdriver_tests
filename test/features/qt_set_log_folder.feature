Feature: MobyBehaviour::QT::ConfigureBehaviour#set_log_folder
  As a test script writer
  I want to enable set the log folder in the target
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

@qt_windows
  Scenario: Set log new log folder to application
    Given I have default sut
    And I launch application "calculator"
    Then I execute "@app.set_log_folder('/logs/testability/temp')"
    And I get current application
    And file /logs/testability/temp/calculator.log should exist
    And I disable logging on the application
    And I delete file /logs/testability/temp/calculator.log

@qt_linux
  Scenario: Set log new log folder to application
    Given I have default sut
    And I launch application "calculator"
    Then I execute "@app.set_log_folder('/tmp')"
    And I enable logging on the application
    And I get current application
    And file /tmp/calculator.log should exist
    And I disable logging on the application
    And I delete file /tmp/calculator.log
