@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#input=
  As a test scripter writer
  I want to use input attribute to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing input attribute (Rename this to be more descriptive)
    Given I have default sut
    When I execute "@sut.input"
    Then exception is not thrown

  Scenario: Testing input= attribute (Rename this to be more descriptive)
    Given I have default sut
    When I execute "@sut.input=:key"
    Then verify "@sut.input==:key"

