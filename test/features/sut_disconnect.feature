@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#disconnect
  As a test scripter writer
  I want to use disconnect method to disconnect contected sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Disconnect @sut
    Given I have default sut
    When I execute "@sut.disconnect"
    Then exception is not thrown
