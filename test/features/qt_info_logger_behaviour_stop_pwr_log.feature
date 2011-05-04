Feature: MobyBehaviour::QT::InfoLoggerBehaviour#stop_pwr_log
  As a test scripter writer
  I want to use stop_pwr_log method to stop the power logging and get the results in xml data
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_windows
  Scenario: Stop logging the pwrory usage of the started application
    Given I have default sut
    And I launch application "testapp"
    And I test code "@app.log_pwr( :interval => 1, :filePath => 'C:\temp' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@pwr_log_data = @sut.state_object( @app.load_pwr_log )"
    And exception is not thrown
    Then I can read the pwr log data
    And I execute "@app.stop_pwr_log"
    And exception is not thrown
    
@qt_symbian
  Scenario: Stop logging the pwrory usage of the started application
    Given I have default sut
    And I launch application "testapp"
    And I test code "@app.log_pwr( :interval => 1, :filePath => 'C:\Data' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@pwr_log_data = @sut.state_object( @app.load_pwr_log )"
    And exception is not thrown
    Then I can read the pwr log data
    And I execute "@app.stop_pwr_log"
    And exception is not thrown

@qt_linux @qt_meego
  Scenario: Stop logging the pwrory usage of the started application
    Given I have default sut
    And I launch application "testapp"
    And I test code "@app.log_pwr( :interval => 1, :filePath => '/tmp/' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@pwr_log_data = @sut.state_object( @app.load_pwr_log )"
    And exception is not thrown
    Then I can read the pwr log data
    And I execute "@app.stop_pwr_log"
    And exception is not thrown

