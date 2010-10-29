@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::ConfigureBehaviour#log_qdebug
  As a test script writer
  I want to log qDebug messages to the targets tdriver logs
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

  Scenario: Log qDebug messages to tdriver logs
    Given I have default sut
    And I launch application "calculator"
    Then I execute "@app.log_qdebug(true)"

  Scenario: Forward all qttasserver logs to qDebug instead of file
    Given I have default sut
    Then I execute "@sut.log_qdebug(true)"
