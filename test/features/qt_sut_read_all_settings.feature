Feature: MobyBehaviour::SUT#settings
  As a test scripter writer
  I want to use read_all_settings method to read all application and system settings
  so that I can test the MobyBehaviour::Qt:Settings behaviour

@qt_windows
  Scenario: Test reading all settings from application settings
    Given I have default sut
	And I insert a setting test_setting and value foobaar
	And I insert a setting test_setting2 and value foobaar2
	When I execute "@settings = @sut.read_all_settings({:organization => 'tDriver', :application => 'qttasserver'})"
	Then the settings hash has a test_setting foobaar key value pair
	Then the settings hash has a test_setting2 foobaar2 key value pair
	And I remove test_setting
	And test_setting is removed
	And I remove test_setting2
	And test_setting2 is removed

@qt_windows
  Scenario: Test setting a setting using path to ini file
    Given I have default sut
	And I write a setting test_setting and value foobaar to C:\qttas\conf\qt_testability.ini
	And I write a setting test_setting2 and value foobaar2 to C:\qttas\conf\qt_testability.ini
	When I execute "@settings = @sut.read_all_settings({:fileName => 'C:\qttas\conf\qt_testability.ini', :format => 'ini'})"
	Then the settings hash has a test_setting foobaar key value pair
	Then the settings hash has a test_setting2 foobaar2 key value pair
	And I clear ini setting test_setting from C:\qttas\conf\qt_testability.ini
	And test_setting is removed from C:\qttas\conf\qt_testability.ini
	And I clear ini setting test_setting2 from C:\qttas\conf\qt_testability.ini
	And test_setting2 is removed from C:\qttas\conf\qt_testability.ini
