Feature: MobyBehaviour::SUT#press_key
  As a test scripter writer
  I want to use press_key method to press a key in the calculator application
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing press_key method with required argument(s) (Rename this to be more descriptive)
    Given I launch application "calculaotr" as @app
    When I execute "@sut.press_key('1')"
    Then exception is not thrown

