Feature: MobyBehaviour::QT::InfoLoggerBehaviour#load_cpu_log
  As a test scripter writer
  I want to use load_cpu_log method to load the cpu log without stopping the logging
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_windows
  Scenario: Load the cpu log without stopping the logging
    Given I launch application "testapp"   
    And I test code "@app.log_cpu({:interval => 1, :filePath => 'C:\temp'})"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    And exception is not thrown
    When I execute "@cpu_log_data = MobyBase::StateObject.new(@app.load_cpu_log)"
    And exception is not thrown
    Then I can read the cpu log data
    And I test code "@app.stop_cpu_log"
    And exception is not thrown

 @qt_linux
  Scenario: Load the cpu log without stopping the logging
    Given I launch application "testapp"
    And I test code "@app.log_cpu({:interval => 1, :filePath => '/tmp/'})"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    And exception is not thrown
    When I execute "@cpu_log_data = MobyBase::StateObject.new(@app.load_cpu_log)"
    And exception is not thrown
    Then I can read the cpu log data
    And I test code "@app.stop_cpu_log"
    And exception is not thrown

