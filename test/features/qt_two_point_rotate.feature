@qt_linux @qt_windows @qt_meego
Feature: MobyBehaviour::QT::Multitouch#two_point_rotate
  As a test script writer
  I want to use rotate method to simulate effect of user doing a rotation operation,
  so that I can test the MobyBehaviour::QT::Multitouch behaviour

  Scenario: Execute 180 degree two point clockwise rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.two_point_rotate(100, 0, :Clockwise, 180, 2)"
    Then the Handle should be rotated -180 degrees

  Scenario: Execute 360 degree two point clockwise rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.two_point_rotate(100, 0, :Clockwise, 360, 2)"
    Then the Handle should be rotated 0 degrees

  Scenario: Execute 90 degree two point clockwise rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.two_point_rotate(100, 0, :Clockwise, 90, 2)"
    Then the Handle should be rotated -270 degrees

  Scenario: Execute 90 degree two point counter clockwise rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.two_point_rotate(100, 0, :CounterClockwise, 90, 2)"
    Then the Handle should be rotated -90 degrees
