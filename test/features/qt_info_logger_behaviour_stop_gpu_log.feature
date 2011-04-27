Feature: MobyBehaviour::QT::InfoLoggerBehaviour#stop_gpu_log
  As a test scripter writer
  I want to use stop_gpu_log method to stop the gpu memory logging and get the results in xml data
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_windows
  Scenario: Stop logging the gpu memory usage of the started application
    Given I have default sut    
    And I launch application "testapp"
    And I test code "@app.log_gpu_mem( :interval => 1, :filePath => 'C:\temp' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    And I test code "@sut.state_object( @app.load_gpu_log )"
    And exception is not thrown
    Then I can read the log data from "@__ret_val"
    When I execute "@app.stop_gpu_log"
    Then exception is not thrown

@qt_linux @qt_meego
  Scenario: Stop logging the gpu memory usage of the started application
    Given I have default sut
    And I launch application "testapp"
    And I test code "@app.log_gpu_mem( :interval => 1, :filePath => '/tmp/' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    And I test code "@sut.state_object( @app.load_gpu_log )"
    And exception is not thrown
    Then I can read the log data from "@__ret_val"
    When I execute "@app.stop_gpu_log"
    Then exception is not thrown

