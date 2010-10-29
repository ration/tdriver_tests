
Feature: MobyBehaviour::QT::ConfigureBehaviour#enable_logger
  As a test script writer
  I want to enable logger in the application 
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

@qt_windows
  Scenario: Enable logger on the application
    Given I have default sut
    And I launch application "calculator"
    And I disable logging on the application
    And I delete file C:/logs/testability/calculator.log
    And file C:/logs/testability/calculator.log should not exist
    Then I execute "@app.enable_logger"
    And I get current application
    And file C:/logs/testability/calculator.log should exist

@qt_windows
  Scenario: Enable logger on the sut
    Given I have default sut
    And I disable logging on the sut
    And I delete file C:/logs/testability/qttasserver.log
    And file C:/logs/testability/qttasserver.log should not exist
    Then I execute "@sut.enable_logger"
    And I get current application
    And file C:/logs/testability/qttasserver.log should exist

@qt_linux @qt_meego
  Scenario: Enable logger on the application
    Given I have default sut
    And I launch application "calculator"
    And I disable logging on the application
    And I delete file /logs/testability/calculator.log
    And file /logs/testability/calculator.log should not exist
    Then I execute "@app.enable_logger"
    And I get current application
    And file /logs/testability/calculator.log should exist

@qt_linux @qt_meego
  Scenario: Enable logger on the sut
    Given I have default sut
    And I disable logging on the sut
    And I delete file /logs/testability/qttasserver.log
    And file /logs/testability/qttasserver.log should not exist
    Then I execute "@sut.enable_logger"
    And I get current application
    And file /logs/testability/qttasserver.log should exist
