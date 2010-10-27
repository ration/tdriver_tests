Feature: MobyBehaviour::SUT#capture_screen
  As a test scripter writer
  I want to use capture_screen method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing capture_screen method with required argument(s) (Rename this to be more descriptive)
    Given I have default sut
	And I launch application "calculator"
    When I execute "@sut.capture_screen(:Filename => './test_data/screen_shot.png')"
    Then exception is not thrown
    And I find and delete the file "./test_data/screen_shot.png"

