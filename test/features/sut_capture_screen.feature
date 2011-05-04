@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#capture_screen
  As a test scripter writer
  I want to use capture_screen method to capture screen in calculator
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing capture_screen method specifying filename to save screenshot to
    Given I have default sut
	  And I launch application "calculator"
    When I execute "@sut.capture_screen( :filename => './test_data/screen_shot.png' )"
    Then exception is not thrown
    And I find and delete the file "./test_data/screen_shot.png"

