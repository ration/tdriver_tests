@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::ConfigureBehaviour#set_log_size
  As a test script writer
  I want to set the log size in the target
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour

  Scenario: Log set the log file size of qttasserver
    Given I have default sut
    Then I execute "@sut.set_log_size(500)"
    And I get current application
    And file /logs/testability/qttasserver.log should exist
	And file size of /logs/testability/qttasserver.log is smaller than 500

