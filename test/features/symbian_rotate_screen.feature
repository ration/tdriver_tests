@qt_symbian 

Feature: MobyBehaviour::Symbian::SUT#rotate_screen
  As a test script writer
  I want to rotate the screen of a symbian application
  so that I can test applications in different orientations

  Scenario: Rotate screen right side up
    Given I have default sut
	Then I execute "@sut.rotate_screen(:rotate_right_up)"
	Then screen rotation is 1
	Then I rotate screen rotate_top_up
	Then screen rotation is 0


  Scenario: Rotate screen top up
    Given I have default sut
	Then I rotate screen rotate_right_up
	Then screen rotation is 1
	Then I execute "@sut.rotate_screen(:rotate_top_up)"
	Then screen rotation is 0

