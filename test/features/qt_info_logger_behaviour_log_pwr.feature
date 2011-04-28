Feature: MobyBehaviour::QT::InfoLoggerBehaviour#log_pwr
  As a test scripter writer
  I want to use log_pwr method to start logging the pwr usage the application or qttasserver
  so that I can test the MobyBehaviour::QT::InfoLoggerBehaviour behaviour

@qt_symbian
  Scenario: Start logging the power usage of the started application
    Given I launch application "testapp"
    When I execute "@app.log_pwr( :interval => 1, :filePath => 'C:\data' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@pwr_log_data = MobyBase::StateObject.new(@app.load_pwr_log)"
    And exception is not thrown
    Then I can read the pwr log data
    And I test code "@app.stop_pwr_log"
    And exception is not thrown

@qt_windows
  Scenario: Start logging the power usage of the started application
    Given I launch application "testapp"
    When I execute "@app.log_pwr( :interval => 1, :filePath => 'C:\tdriver' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@pwr_log_data = MobyBase::StateObject.new(@app.load_pwr_log)"
    And exception is not thrown
    Then I can read the pwr log data
    And I test code "@app.stop_pwr_log"
    And exception is not thrown

@qt_linux @qt_meego
  Scenario: Start logging the power usage of the started application
    Given I launch application "testapp"
    When I execute "@app.log_pwr( :interval => 1, :filePath => '/tmp/' )"
    And exception is not thrown
    And I test code "@app.Node.flick( :Left )"
    When I test code "@pwr_log_data = MobyBase::StateObject.new(@app.load_pwr_log)"
    And exception is not thrown
    Then I can read the pwr log data
    And I test code "@app.stop_pwr_log"
    And exception is not thrown
