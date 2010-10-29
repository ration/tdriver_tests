@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#gesture_to_object
  As a test script writer
  I want to use gesture_to_object method to move an object to another in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: The gesture_to_object method requires a target test object and gesture speed
    Given I launch application "testapp" as "@app"
	And the Triangle is at location 100, 100
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.gesture_to_object(@_triangle, 1)"
    Then the Node has the x attribute with value 100
	And the Node has the y attribute with value 100

  Scenario: The 'optional_parameters' argument can be left empty to use default values
    Given I launch application "testapp" as "@app"
	And the Triangle is at location 200, 200
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.gesture_to_object(@_triangle, 1, {})"
    Then the Node has the x attribute with value 200
	And the Node has the y attribute with value 200

  Scenario: The 'optional_params' key :button can be used to set the button used in the gesture
    Given I launch application "testapp" as "@app"
	And the Triangle is at location 300, 300
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.gesture_to_object(@_triangle, 1, { :button => :Left} )"
    Then the Node has the x attribute with value 300
	And the Node has the y attribute with value 300

  Scenario: The 'optional_params' key :isDrag can be used to set whether the gesture is performed as a drag (short stops at start and end)
    Given I launch application "testapp" as "@app"
	And the Triangle is at location 100, 300
	And the Triangle is assigned to the @_triangle object
    When I execute "@app.Node.gesture_to_object(@_triangle, 1, { :isDrag => :true} )"
    Then the Node has the x attribute with value 100
	And the Node has the y attribute with value 300

