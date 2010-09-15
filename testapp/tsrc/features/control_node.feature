	Feature: TDriver test application controls node
	As a TDriver developer
	I want TDriver test application to have node controls	
	so that application can be used for testing TDriver
	
	Scenario: Button New node
		Given the "testapp" is running
	    And menu activated
	    When I tap "Node" button
		And I deactivate menu
		Then it should create new "green" node to random location in test application

	Scenario: Draggable node tap
		Given the "testapp" is running
		When I check that 1 node exists
		And I tap_down the node
		Then it should change color of node from "green" to "yellow"

#	Scenario: Draggable triangle tap
#		Given the "testapp" is running
#		When I tap_down the triangle
#		Then it should change color of triangle from "magenta" to "darkMagenta"

#	Scenario: Draggable node drag
#		Given the "testapp" is running
#		When I check that 1 node exists
#		And I drag the node
#		Then node should change position according the given drag

#	Scenario: Draggable node name
#		Given the "testapp" is running
#		When I check that 1 node exists
#		Then its name should be "Node1"

#	Scenario: Flickable node flick
#		Given the "testapp" is running
#		When I check that 1 node exists
#		And I flick the node
#		Then it should change position	

