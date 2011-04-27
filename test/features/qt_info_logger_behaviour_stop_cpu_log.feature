Feature: MobyBehaviour::QT::InfoLoggerBehaviour#stop_cpu_log
  As a test scripter writer
  I want to use stop_cpu_log method to stop the cpu load logging and get the results in xml data
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_windows
  Scenario: Stop logging the cpu usage of the started application
    Given I have default sut    
    And I launch application "testapp"
    And I test code "@app.log_cpu( :interval => 1, :filePath => 'C:\temp' )"    
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@cpu_log_data = @sut.state_object( @app.load_cpu_log )"
    And exception is not thrown
    Then I can read the cpu log data
    And I execute "@app.stop_cpu_log"
    And exception is not thrown

@qt_linux @qt_meego
  Scenario: Stop logging the cpu usage of the started application
    Given I have default sut    
    And I launch application "testapp"
    And I test code "@app.log_cpu( :interval => 1, :filePath => '/tmp/' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@cpu_log_data = @sut.state_object( @app.load_cpu_log )"
    And exception is not thrown
    Then I can read the cpu log data
    And I execute "@app.stop_cpu_log"
    And exception is not thrown

