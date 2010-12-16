@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SwitchboxBehaviour#power_down
  As a test scripter writer
  I want to use power_down method to cut the power down from device using switchbox command
  so that I can test the MobyBehaviour::SwitchboxBehaviour behaviour

  Scenario: Execute power_down command
    Given I have default sut
    And I set the mandatory switchbox parameters for sut
    When I execute "@sut.power_down()"
    Then exception is not thrown
    And I test code "@sut.power_up()"
    And exception is not thrown


