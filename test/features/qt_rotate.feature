@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::QT::Multitouch#rotate
  As a test script writer
  I want to use rotate method to simulate effect of user doing a rotation operation,
  so that I can test the MobyBehaviour::QT::Multitouch behaviour

  Scenario: Execute 180 degree one point clockwise custom rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.rotate({:type => :one_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 180, :speed => 3, :direction => :Vertical})"
    Then the Handle should be rotated 180 degrees

  Scenario: Execute 360 degree one point clockwise custom rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.rotate({:type => :one_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 360, :speed => 3, :direction => :Vertical})"
    Then the Handle should be rotated 0 degrees

  Scenario: Execute 90 degree one point clockwise custom rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.rotate({:type => :one_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 90, :speed => 3, :direction => :Vertical})"
    Then the Handle should be rotated 90 degrees

  Scenario: Execute 90 degree one point counter clockwise custom rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.rotate({:type => :one_point, :radius => 100, :rotate_direction => :CounterClockwise, :distance => 90, :speed => 3, :direction => :Vertical})"
    Then the Handle should be rotated -90 degrees

  Scenario: Execute 180 degree two point clockwise custom rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.rotate({:type => :two_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 180, :speed => 3, :direction => :Vertical})"
    Then the Handle should be rotated -180 degrees

  Scenario: Execute 360 degree two point clockwise custom rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.rotate({:type => :two_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 360, :speed => 3, :direction => :Vertical})"
    Then the Handle should be rotated 0 degrees

  Scenario: Execute 90 degree two point clockwise custom rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.rotate({:type => :two_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 90, :speed => 3, :direction => :Vertical})"
    Then the Handle should be rotated -270 degrees

  Scenario: Execute 90 degree two point counter clockwise custom rotation
    Given I launch application "matti_multitouchapp"
	And I press the next 1 times
	Then I execute "@app.MainWindow.rotate({:type => :two_point, :radius => 100, :rotate_direction => :CounterClockwise, :distance => 90, :speed => 3, :direction => :Vertical})"
    Then the Handle should be rotated -90 degrees
