@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#shell_command
  As a test scripter writer
  I want to use shell_command method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing shell_command method with required argument(s) (Rename this to be more descriptive)
    Given I have default sut
    And I launch testapp for 20 seconds
    When I execute "$obj=@sut.shell_command($pid)"
    Then the pid should be still running

  Scenario: Testing shell_command method with optional argument 'param', to kill the process
    Given I have default sut
    And I launch testapp for 20 seconds
    When I execute "$obj=@sut.shell_command($pid,{:kill => 'true'})"
    Then application "testapp" is not running





