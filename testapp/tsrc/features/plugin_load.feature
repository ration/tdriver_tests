Feature: MATTI test application loads testability plugin
	As a MATTI developer
	I want MATTI test application to load testability plugin
	so that application can be used without changes to Qt
	
  Scenario: Application start
    Given no active plugins
    And I run "testapp"
    When "testapp" starts it loads testability plugin
    And I close "testapp" application
    Then "testapp" should no longer be running

  Scenario: Application kill
    Given no active plugins
    And I run "testapp"
    When "testapp" starts it loads testability plugin
    And I kill "testapp" application
    Then "testapp" should no longer be running

