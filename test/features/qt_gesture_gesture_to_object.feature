Feature: MobyBehaviour::QT::Gesture#gesture_to_object
  As a test script writer
  I want to use gesture_to_object method to move an object to another in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing gesture_to_object method with required arguments
    Given I launch application "testapp" as "@app"
	And the Triangle is at location 100, 100
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.gesture_to_object(@_triangle, 1)"
    Then the Node has the x attribute with value 100
	And the Node has the y attribute with value 100

  Scenario: Testing gesture_to_object method with optional argument 'optional_params' 
    Given I launch application "testapp" as "@app"
	And the Triangle is at location 200, 200
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.gesture_to_object(@_triangle, 1, {})"
    Then the Node has the x attribute with value 200
	And the Node has the y attribute with value 200

  Scenario: Testing gesture_to_object method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application "testapp" as "@app"
	And the Node is at location 300, 300
	And the Node is assigned to the @_node object
    When I execute "@app.Triangle.gesture_to_object(@_node, 1, { :button => :Left} )"
    Then the Node has the x attribute with value 300
	And the Node has the y attribute with value 300

  Scenario: Testing gesture_to_object method with optional argument 'isDrag' (Rename this to be more descriptive)
    Given I launch application "testapp" as "@app"
	And the Triangle is at location 100, 300
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.gesture_to_object(@_triangle, 1, { :isDrag => :true} )"
    Then the Node has the x attribute with value 100
	And the Node has the y attribute with value 300

