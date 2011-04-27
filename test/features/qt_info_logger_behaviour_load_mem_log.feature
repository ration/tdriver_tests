Feature: MobyBehaviour::QT::InfoLoggerBehaviour#load_mem_log
  As a test scripter writer
  I want to use load_mem_log method to load the cpu log without stopping the logging
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_windows
  Scenario: Load the mem log without stopping the logging
    Given I have default sut    
    And I launch application "testapp"
    And I test code "@app.log_mem( :interval => 1, :filePath => 'C:\temp' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    And exception is not thrown  
    When I execute "@mem_log_data = @sut.state_object( @app.load_mem_log )"
    And exception is not thrown
    Then I can read the mem log data
    And I test code "@app.stop_mem_log"
    And exception is not thrown

@qt_linux @qt_meego
  Scenario: Load the mem log without stopping the logging
    Given I have default sut    
    And I launch application "testapp"
    And I test code "@app.log_mem( :interval => 1, :filePath => '/tmp/' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    And exception is not thrown
    When I execute "@mem_log_data = @sut.state_object( @app.load_mem_log )"
    And exception is not thrown
    Then I can read the mem log data
    And I test code "@app.stop_mem_log"
    And exception is not thrown

