Feature: MobyBehaviour::QT::ConfigureBehaviour#clear_log
  As a test script writer
  I want to enable logger in the application 
  so that I can test the MobyBehaviour::QT::ConfigureBehaviour behaviour


  Scenario: Clear the log file for sut
    Given I have default sut
    And I delete file C:/logs/testability/temp/qttasserver.log
	And change sut log folder C:/logs/testability/temp
	And I enable logging on the sut
    And I get current application
    And file C:/logs/testability/temp/qttasserver.log should exist
	And I store the file size of C:/logs/testability/temp/qttasserver.log
    Then I execute "@sut.clear_log"
	And I make sure the file size of C:/logs/testability/temp/qttasserver.log is smaller than stored file size
	And change sut log folder C:/logs/testability
    And I delete file C:/logs/testability/temp/qttasserver.log

@qt_linux 
  Scenario: Clear the log file for sut
    Given I have default sut
    And I delete file /logs/testability/temp/qttasserver.log
	And change sut log folder /logs/testability/temp
	And I enable logging on the sut
    And I get current application
    And file /logs/testability/temp/qttasserver.log should exist
	And I store the file size of /logs/testability/temp/qttasserver.log
    Then I execute "@sut.clear_log"
	And I make sure the file size of /logs/testability/temp/qttasserver.log is smaller than stored file size
	And change sut log folder /logs/testability
    And I delete file /logs/testability/temp/qttasserver.log

@qt_symbian @qt_meeego
  Scenario: Clear the log file for sut
    Given I have default sut
	And change sut log folder C:/logs/testability/temp
	And I enable logging on the sut
    And I get current application
    Then I execute "@sut.clear_log"
    And exception is not thrown
