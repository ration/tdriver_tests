@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#unfreeze
  As a test scripter writer
  I want to use freeze to freeze the current ui state
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Unfreeze the current sut ui
    Given I have default sut
    And I test code "@sut.freeze"
    And exception is not thrown
    When I execute "@sut.unfreeze"
    Then exception is not thrown


