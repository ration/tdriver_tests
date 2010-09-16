@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: TestObject::drag
	As a test scripter writer
	I want to use drag method to drag objects in applications
	so that I can test the application behaviour


	Scenario: Drag object up
		Given I launch application "testapp"
		Then object named "Scramble" is not visible on screen
	        When I execute "@app.ControlTab( :name => 'ControlTab').drag(:Up, 10)"
        	Then object named "Scramble" is visible on screen
