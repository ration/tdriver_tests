
Feature: MobyBehaviour::QT::ConfigureBehaviour#disable_logger
  As a test script writer
  I want to disable logger in the target
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

@qt_windows 
  Scenario: Disable logger on the application
    Given I have default sut
    And I launch application "calculator"
    Then I execute "@app.disable_logger"
    And I delete file C:/logs/testability/calculator.log
    And I get current application
    And file C:/logs/testability/calculator.log should not exist

@qt_windows 
  Scenario: Disable logger on the sut
    Given I have default sut
    Then I execute "@sut.disable_logger"
    And I delete file C:/logs/testability/qttasserver.log
    And I get current application
    And file C:/logs/testability/qttasserver.log should not exist

@qt_linux @qt_meego
  Scenario: Disable logger on the application
    Given I have default sut
    And I launch application "calculator"
    Then I execute "@app.disable_logger"
    And I delete file /logs/testability/calculator.log
    And I get current application
    And file /logs/testability/calculator.log should not exist

@qt_linux @qt_meego
  Scenario: Disable logger on the sut
    Given I have default sut
    Then I execute "@sut.disable_logger"
    And I delete file /logs/testability/qttasserver.log
    And I get current application
    And file /logs/testability/qttasserver.log should not exist
