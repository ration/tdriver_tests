Feature: MATTI test application controls reset
	As a MATTI developer
	I want MATTI test application to have reset button
	so that test application canvas can be reseted
	
	Scenario: Button reset
		Given the "testapp" is running
	    And menu activated
		When I add 5 nodes
		And I add 5 rectangles
		And I tap "Reset" button 
		And I deactivate menu
		Then the view should have 0 of nodes and rectangles
