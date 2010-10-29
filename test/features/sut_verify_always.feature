@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#verify_always
  As a test scripter writer
  I want to use verify_always method to add a verification block in the sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing verify_always method with required argument(s) (Rename this to be more descriptive)
    Given I have default sut
    When I execute "@sut.verify_always( true )"
    Then exception is not thrown

  Scenario: Testing verify_always method with optional argument 'message' (Rename this to be more descriptive)
    Given I have default sut
    When I execute "@sut.verify_always( true, 'Everything is ok!' )"
    Then exception is not thrown

  Scenario: Testing verify_always method with optional argument 'block' (Rename this to be more descriptive)
    Given I have default sut
    When I execute "@sut.verify_always( true, 'Everything is ok!' ){ true == 1 }"
    Then exception is not thrown

