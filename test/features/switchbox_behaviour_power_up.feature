@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SwitchboxBehaviour#power_up
  As a test scripter writer
  I want to use power_up method to power up from device using switchbox command
  so that I can test the MobyBehaviour::SwitchboxBehaviour behaviour

  Scenario: Execute power_up command
    Given I have default sut
    And I set the mandatory switchbox parameters for sut
    When I execute "@sut.power_up"
    Then exception is not thrown

