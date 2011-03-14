Feature: MobyBehaviour::SUT#settings
  As a test scripter writer
  I want to use set_setting method to remove application and system settings
  so that I can test the MobyBehaviour::Qt:Settings behaviour

@qt_windows @qt_linux @qt_meego
  Scenario: Test removing a setting using organization and application
    Given I have default sut
	And I insert a setting test_setting and value foobaar
	And the test_setting value foobaar can be read 
    When I execute "@sut.remove_settings({:organization => 'tDriver', :application => 'qttasserver'},['test_setting'])"
	Then test_setting is removed

@qt_windows
  Scenario: Test setting a setting using path to ini file
    Given I have default sut
	And I write a setting test_setting and value foobaar to C:\qttas\conf\qt_testability.ini
    And the test_setting value foobaar can be read from C:\qttas\conf\qt_testability.ini
    When I execute "@sut.remove_settings({:fileName => 'C:\qttas\conf\qt_testability.ini', :format => 'ini'},['test_setting'])"
	And test_setting is removed from C:\qttas\conf\qt_testability.ini

@qt_linux @qt_meego
  Scenario: Test setting a setting using path to ini file
    Given I have default sut
	And I write a setting test_setting and value foobaar to /etc/qt_testability/qt_testability.ini
    And the test_setting value foobaar can be read from /etc/qt_testability/qt_testability.ini
    When I execute "@sut.remove_settings({:fileName => '/etc/qt_testability/qt_testability.ini', :format => 'ini'},['test_setting'])"
	And test_setting is removed from /etc/qt_testability/qt_testability.ini
