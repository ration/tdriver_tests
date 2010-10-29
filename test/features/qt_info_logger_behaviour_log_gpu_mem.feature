Feature: MobyBehaviour::QT::InfoLoggerBehaviour#log_gpu_mem
  As a test scripter writer
  I want to use log_gpu_mem method to log the gpu memory usage of the application
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_windows
  Scenario: Start logging the gpu mem usage of the started application
    Given I launch application "testapp"
    When I execute "@app.log_gpu_mem({:interval => 1, :filePath => 'C:\temp'})"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@gpu_log_data = MobyBase::StateObject.new(@app.load_gpu_log)"
    And exception is not thrown
    Then I can read the gpu log data
    And I test code "@app.stop_gpu_log"
    And exception is not thrown

@qt_linux
  Scenario: Start logging the gpu mem usage of the started application
    Given I launch application "testapp"
    When I execute "@app.log_gpu_mem({:interval => 1, :filePath => '/tmp/'})"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@gpu_log_data = MobyBase::StateObject.new(@app.load_gpu_log)"
    And exception is not thrown
    Then I can read the gpu log data
    And I test code "@app.stop_gpu_log"
    And exception is not thrown
