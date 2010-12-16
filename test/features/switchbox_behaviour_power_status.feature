@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SwitchboxBehaviour#power_status
  As a test scripter writer
  I want to use power_status method to check the switchbox power status
  so that I can test the MobyBehaviour::SwitchboxBehaviour behaviour

  Scenario: Execute power_status command
    Given I have default sut
    And I set the mandatory switchbox parameters for sut
    And I test code "@sut.power_up()"
    And exception is not thrown
    When I execute "@power_status=@sut.power_status()"
    Then exception is not thrown
    And The power status is true
