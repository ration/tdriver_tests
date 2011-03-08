Feature: MobyBehaviour::SUT#settings
  As a test scripter writer
  I want to use set_setting method to set application and system settings
  so that I can test the MobyBehaviour::Qt:Settings behaviour

@qt_windows
  Scenario: Test setting a setting using organization and application
    Given I have default sut
    When I execute "@sut.set_settings({:organization => 'tDriver', :application => 'qttasserver'},{ :test_setting => 'foobaar'})"
    Then the test_setting value foobaar can be read 
	And I remove test_setting
	And test_setting is removed

@qt_windows
  Scenario: Test setting a setting using path to ini file
    Given I have default sut
    When I execute "@sut.set_settings({:fileName => 'C:\qttas\conf\qt_testability.ini', :format => 'ini'},{ :test_setting => 'foobaar'})"
    Then the test_setting value foobaar can be read from C:\qttas\conf\qt_testability.ini
	And I clear ini setting test_setting from C:\qttas\conf\qt_testability.ini
	And test_setting is removed from C:\qttas\conf\qt_testability.ini

