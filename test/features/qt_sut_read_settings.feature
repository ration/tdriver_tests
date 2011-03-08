Feature: MobyBehaviour::SUT#settings
  As a test scripter writer
  I want to use read_settings method to read application and system settings
  so that I can test the MobyBehaviour::Qt:Settings behaviour

@qt_windows
  Scenario: Test reading a single settings from application settings.
    Given I have default sut
	And I insert a setting test_setting and value foobaar
	When I execute "@settings = @sut.read_settings({:organization => 'tDriver', :application => 'qttasserver'}, ['test_setting'])"
	Then the settings hash has a test_setting foobaar key value pair
	And I remove test_setting
	And test_setting is removed

@qt_windows
  Scenario: Test reading a single setting from an ini file.
    Given I have default sut
	And I write a setting test_setting and value foobaar to C:\qttas\conf\qt_testability.ini
	When I execute "@settings = @sut.read_settings({:fileName => 'C:\qttas\conf\qt_testability.ini', :format => 'ini'}, ['test_setting'])"
	Then the settings hash has a test_setting foobaar key value pair
	And I clear ini setting test_setting from C:\qttas\conf\qt_testability.ini
	And test_setting is removed from C:\qttas\conf\qt_testability.ini
