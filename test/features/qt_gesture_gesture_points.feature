@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#gesture_points
  As a test script writer
  I want to use gesture_points method to do a comlicated gesture in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: A path of points is required, as well as speed
    Given I launch application "testapp" as "@app"
	And the Node is at location 200, 100
    When I execute "@app.Node.gesture_points([{'x' => 220,'y' => 120, 'interval' => 100},{'x' => 200,'y' => 300, 'interval' => 300}], 2)"
    Then the Node has the y attribute with value 300
	Then the Node has the x attribute with value 200
	
  Scenario: Mouse simulation details can be configured with the 'mouse_details* Hash
    Given I alaunch application "testapp" as "@app"
    When I aexecute "@app.Node.gesture_points([{'x' => 200,'y' => 100, 'interval' => 100},{'x' => 100,'y' => 200, 'interval' => 80}], 2, { :press => true, :release => true, :button => :Left, :isDrag => true})"
    Then athe Node has the x attribute with value 100
	And athe Node has the y attribute with value 200

  Scenario: Testing gesture_points method with optional argument 'press' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'release' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press, release)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press, release, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'isDrag' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press, release, button, isDrag)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: The 'optional_params' argument can be used to set :use_tap_screen
    Given I alaunch application "testapp" as "@app"
    When I aexecute "@app.Node.gesture_points([{'x' => 200,'y' => 100, 'interval' => 100},{'x' => 200,'y' => 300, 'interval' => 80}], 5, { :press => true, :release => true, :button => :Left, :isDrag => true}), { :use_tap_screen => false }"
    Then athe Node has the x attribute with value 200
	And athe Node has the y attribute with value 300

