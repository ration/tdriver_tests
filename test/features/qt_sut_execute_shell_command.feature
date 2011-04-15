@qt_linux @qt_windows @qt_meego

Feature: MobyBehaviour::QT::SUT#execute_shell_command
  As a test scripter writer
  I want to use execute_shell_command method to execute in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing execute_shell_command method with required argument(s) 
    Given I have default sut
    When I execute "@sut.execute_shell_command('dir')"
    Then exception is not thrown

  Scenario: Testing execute_shell_command method with optional argument ':detached' 
    Given I have default sut
  	Then I make sure that testapp is not running
    When I execute "@sut.execute_shell_command('testapp -r 1', :detached => 'true')"
    Then exception is not thrown

  Scenario: Testing execute_shell_command method with optional argument ':threaded' 
    Given I have default sut
  	Then I make sure that testapp is not running
    When I execute "@pid = @sut.execute_shell_command('testapp -r 1', :threaded => 'true')"
    Then the retuned @pid is not null
    
  Scenario: Testing execute_shell_command method with optional argument ':wait' 
    Given I have default sut
  	Then I make sure that testapp is not running
    When I execute "@sut.execute_shell_command('testapp -r 5', :wait => 'true')"
    Then exception is not thrown

  Scenario: Testing execute_shell_command method with optional argument ':timeout' 
    Given I have default sut
	  Then I make sure that testapp is not running
    When I execute "@sut.execute_shell_command('testapp -r 6', {:wait => 'true', :timeout => 5})"
    Then get a RuntimeError exception
