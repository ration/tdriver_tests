Feature: MobyBehaviour::QT::InfoLoggerBehaviour#load_gpu_log
  As a test scripter writer
  I want to use load_gpu_log method to load the gpu log without stopping the logging
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_windows
  Scenario: Load the gpu log without stopping the logging
    Given I launch application "testapp"
    And I test code "@app.log_gpu_mem( :interval => 1, :filePath => 'C:\temp' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    And exception is not thrown
    When I execute "@gpu_log_data = MobyBase::StateObject.new(@app.load_gpu_log)"
    And exception is not thrown
    Then I can read the gpu log data
    And I test code "@app.stop_gpu_log"
    And exception is not thrown

@qt_linux @qt_meego
  Scenario: Load the gpu log without stopping the logging
    Given I launch application "testapp"
    And I test code "@app.log_gpu_mem( :interval => 1, :filePath => '/tmp/' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    And exception is not thrown
    When I execute "@gpu_log_data = MobyBase::StateObject.new(@app.load_gpu_log)"
    And exception is not thrown
    Then I can read the gpu log data
    And I test code "@app.stop_gpu_log"
    And exception is not thrown

