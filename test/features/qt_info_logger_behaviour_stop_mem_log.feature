Feature: MobyBehaviour::QT::InfoLoggerBehaviour#stop_mem_log
  As a test scripter writer
  I want to use stop_mem_log method to stop the memory logging and get the results in xml data
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_windows @qt_symbian
  Scenario: Stop logging the memory usage of the started application
    Given I launch application "testapp"
    And I test code "@app.log_mem({:interval => 1, :filePath => 'C:\temp'})"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@mem_log_data = MobyBase::StateObject.new(@app.load_mem_log)"
    And exception is not thrown
    Then I can read the mem log data
    And I execute "@app.stop_mem_log"
    And exception is not thrown

@qt_linux @qt_meego
  Scenario: Stop logging the memory usage of the started application
    Given I launch application "testapp"
    And I test code "@app.log_mem({:interval => 1, :filePath => '/tmp/'})"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@mem_log_data = MobyBase::StateObject.new(@app.load_mem_log)"
    And exception is not thrown
    Then I can read the mem log data
    And I execute "@app.stop_mem_log"
    And exception is not thrown

