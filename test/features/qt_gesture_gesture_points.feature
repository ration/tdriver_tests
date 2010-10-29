Feature: MobyBehaviour::QT::Gesture#gesture_points
  As a test scripter writer
  I want to use gesture_points method to use recorded gesture motions
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Gesture points to given object using default values
    Given I have default sut
    And I launch application "testapp"
    And I hide the triangle
    And I drag node 1 to the center of the screen
    When I execute 
               """
                @app.Node(:name => @nodeid).gesture_points([
		{'x' => @x.to_i, 'y' => @y.to_i, 'interval' => 1.828 },
		{'x' => 455, 'y' => 268, 'interval' => 0.172 },
		{'x' => 456, 'y' => 269, 'interval' => 0.0 },
		{'x' => 457, 'y' => 269, 'interval' => 0.016 },
		{'x' => 459, 'y' => 270, 'interval' => 0.0 },
		{'x' => 461, 'y' => 270, 'interval' => 0.016 }],4.61)
               """
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing gesture_points method with optional argument 'mouse_details' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details)"
    Then [ADD_YOUR_VERIFICATION_HERE]

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

  Scenario: Testing gesture_points method with optional argument 'optional_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].gesture_points(points, duration, mouse_details, press, release, button, isDrag, optional_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

