@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SwitchboxBehaviour#reset
  As a test scripter writer
  I want to use reset method to reset device using switchbox commands
  so that I can test the MobyBehaviour::SwitchboxBehaviour behaviour

  Scenario: Execute reset command
    Given I have default sut
    And I set the mandatory switchbox parameters for sut
    When I execute "@sut.reset()"
    Then exception is not thrown

