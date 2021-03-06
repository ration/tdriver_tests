Feature: MobyBehaviour::SUT#run
  As a test scripter writer
  I want to use run method to run application
  so that I can test the MobyBehaviour::SUT behaviour

@qt_linux @qt_windows @qt_symbian @qt_meego
  Scenario: Start testable application using run method with application name
    Given I have default sut
    When I execute "@app = @sut.run('testapp')"
    And exception is not thrown
    Then testapp should be the top most application
    And I test code "@app.close"
    And application "testapp" is not running

@qt_linux @qt_windows @qt_symbian @qt_meego
  Scenario: Start testable application using run method
    Given I have default sut
    When I execute "@app = @sut.run(:name => 'testapp')"
    And exception is not thrown
    Then testapp should be the top most application
    And I test code "@app.close"
    And application "testapp" is not running
    
@qt_linux @qt_windows @qt_meego
  Scenario: Start testable application using run method and setting environment variables
    Given I have default sut
    When I execute "@app = @sut.run(:name => 'testapp', :environment => 'TESTAPP_VIEW=EditArea')"
    And exception is not thrown
    Then testapp should be the top most application
    And "EditArea" view is visible
    And I test code "@app.close"
    And application "testapp" is not running
  
@qt_linux @qt_windows @qt_meego
  Scenario: Start testable application using run method and setting other environment variables
    Given I have default sut
    When I execute "@app = @sut.run(:name => 'testapp', :environment => 'TESTAPP_VIEW=WebKitArea')"
    And exception is not thrown
    Then testapp should be the top most application
    And "WebKitArea" view is visible
    And I test code "@app.close"
    And application "testapp" is not running

@qt_linux @qt_windows @qt_symbian @qt_meego
Scenario: Try to start non existing application
    Given I have default sut
    When I execute "@app = @sut.run(:name => 'thisappdoesnotexist')"  
    And exception is thrown
    And application "testapp" is not running

@qt_linux @qt_meego
Scenario: Try to start application with exact path
    Given I have default sut
    When I execute "@app = @sut.run(:name => '/usr/bin/testapp')"
    And exception is not thrown
    Then testapp should be the top most application
    And I test code "@app.close"
    And application "testapp" is not running

@qt_linux @qt_meego
Scenario: Try to start non existing application with exact path
    Given I have default sut
    When I execute "@app = @sut.run(:name => '/usr/bin/thisappdoesnotexist')"  
    And exception is thrown
    And application "testapp" is not running

@qt_linux @qt_windows @qt_meego @qt_symbian
  Scenario: Start application twice, restart it the second time
    Given I have default sut
    When I test code "@app = @sut.run(:name => 'testapp')"
    And exception is not thrown
    And I execute "@app = @sut.run(:name => 'testapp', :restart_if_running => true)"
    Then testapp should be the top most application
    And I test code "@app.close"
    And application "testapp" is not running

