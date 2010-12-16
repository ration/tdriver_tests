@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#freeze
  As a test scripter writer
  I want to use freeze to freeze the current ui state
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Freeze the current sut ui
    Given I have default sut
    When I execute "@sut.freeze()"
    Then exception is not thrown
    And I test code "@sut.unfreeze()"
    And exception is not thrown

