
Feature: TDriver test application controls scramble
	As a TDriver developer
	I want TDriver test application to have scramble button
	so that test application canvas can be scrambled
	
	Scenario: Button scramble
		Given the "testapp" is running
	    And menu activated
		When I add 5 nodes
		And I add 5 rectangles 
		And I tap "Scramble" button
		And I deactivate menu
		Then it should move all nodes and rectangles to new random locations

