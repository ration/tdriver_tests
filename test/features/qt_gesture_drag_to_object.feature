@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#drag_to_object
  As a test script writer
  I want to use drag_to_object method to move an object to another in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Basic drag_to:object use requires that another test object is given as the target
	Given I launch application "testapp" as "@app"
	And the Triangle is at location 100, 100
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.drag_to_object(@_triangle)"
    Then the new location of the Node is 100, 100

  Scenario: The used button can be defined
    Given I launch application "testapp" as "@app"
	And the Triangle is at location 300, 100
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.drag_to_object(@_triangle, :Left)"
    Then the new location of the Node is 300, 100	

  Scenario: The 'optional_params' argument can be used to set :use_tap_screen
    Given I launch application "testapp" as "@app"
	And the Triangle is at location 100, 300
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.drag_to_object(@_triangle, :Left, { :use_tap_screen => true })"
    Then the new location of the Node is 100, 300

