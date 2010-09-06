Feature: MATTI test application controls rectangle
	As a MATTI developer
	I want MATTI test application to have rectangle controls
	so that application can be used for testing MATTI
	
	Scenario: Button New rectangle
		Given the "testapp" is running
	    And menu activated
		When I tap "Reset" button
		When I tap "Rectangle" button
		And I deactivate menu
		Then it should create new "red" rectangle to random location in test application

	Scenario: Rectangle name
		Given the "testapp" is running
	    And menu activated
		When I tap "Rectangle" button	
		Then rectangles name should be "Rectangle1"

	Scenario: tap rectangle
		Given the "testapp" is running
	    And menu activated
		When I tap "Reset" button
		And I deactivate menu
		And I check that one rectangle exists
		And I tap down the rectangle
		Then it should change fill color of rectangle from "red" to "black"
	
	Scenario: Draggable rectangle
		Given the "testapp" is running
		When I check that one rectangle exists
		And I drag the rectangle
		Then rectangle should change position according the given drag

	Scenario: node on top of and off rectangle
		Given the "testapp" is running 
		When I check that one rectangle exists
		And I check that 1 node exists
		And I drag the node to top of rectangle
		Then rectangle should change fill color to "blue"
		And I drag the node
		And rectangle should change fill color to "red"

	Scenario: node on top of and off rectangle using gesture
		Given the "testapp" is running 
		When I check that one rectangle exists
		And I check that 1 node exists
		And I gesture the node to top of rectangle
		Then rectangle should change fill color to "blue"
		And I drag the node
		And rectangle should change fill color to "red"
