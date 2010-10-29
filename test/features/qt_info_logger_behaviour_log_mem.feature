Feature: MobyBehaviour::QT::InfoLoggerBehaviour#log_mem
  As a test scripter writer
  I want to use log_mem method to log the memory usage of the application or sut
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_windows
  Scenario: Start logging the mem usage of the started application
    Given I launch application "testapp"
    When I execute "@app.log_mem( :interval => 1, :filePath => 'C:\temp' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@mem_log_data = MobyBase::StateObject.new(@app.load_mem_log)"
    And exception is not thrown
    Then I can read the mem log data
    And I test code "@app.stop_mem_log"
    And exception is not thrown

@qt_linux @qt_meego
  Scenario: Start logging the mem usage of the started application
    Given I launch application "testapp"
    When I execute "@app.log_mem( :interval => 1, :filePath => '/tmp/' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@mem_log_data = MobyBase::StateObject.new(@app.load_mem_log)"
    And exception is not thrown
    Then I can read the mem log data
    And I test code "@app.stop_mem_log"
    And exception is not thrown

