@qt_linux @qt_windows
Feature: MobyBehaviour::QT::ConfigureBehaviour#log_to_qdebug
  As a test script writer
  I want send the tdriver logs to qDebug
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

  Scenario: Forward application logs to qDebug instead of file
    Given I have default sut
    And I launch application "calculator"
    Then I execute "@app.log_to_qdebug(true)"
    And I delete file /logs/testability/calculator.log
    And I get current application
    And file /logs/testability/temp/calculator.log should not exist

  Scenario: Forward all qttasserver logs to qDebug instead of file
    Given I have default sut
    Then I execute "@sut.log_to_qdebug(true)"
    And I delete file /logs/testability/qttasserver.log
    And I get current application
    And file /logs/testability/temp/calculator.log should not exist   
