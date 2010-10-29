Feature: MobyBehaviour::SUT#press_key
  As a test scripter writer
  I want to use press_key method to press a key in the calculator application
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing press_key method with required argument(s) (Rename this to be more descriptive)
    Given I have default sut
    And I launch application "calculator"
    When I execute "@sut.press_key(:k1)"
    Then exception is not thrown

