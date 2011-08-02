@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#gesture_points
  As a test script writer
  I want to use gesture_points method to do a comlicated gesture in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: A path of points is required, as well as duration
    Given I launch application "testapp" as "@app"	
  	And the Node is at location 200, 100
    When I execute 
    """
      @app.Node.gesture_points(
        [
          {'x' => 220, 'y' => 120, 'interval' => 100},
          {'x' => 200, 'y' => 300, 'interval' => 300}
        ], 
        2
      )
    """
  	Then the scenepos of Node is 180,280
		
  Scenario: Mouse simulation details can be configured with the mouse details hash
    Given I launch application "testapp" as "@app"
  	And the Node is at location 200, 100
    When I execute 
    """
      @app.Node.gesture_points(
        [
          {'x' => 220, 'y' => 120, 'interval' => 100},
          {'x' => 100, 'y' => 200, 'interval' => 80}
        ], 
        2, 
        { 
          :press => true, 
          :release => true, 
          :button => :Left, 
          :isDrag => true
        }
      )
    """
  	Then the scenepos of Node is 80,180

  Scenario: The optional parameters argument can be used to set :use_tap_screen value
    Given I launch application "testapp" as "@app"
  	And the Node is at location 200, 100
    When I execute 
    """
      @app.Node.gesture_points(
        [
          {'x' => 220, 'y' => 120, 'interval' => 100},
          {'x' => 200, 'y' => 300, 'interval' => 80}
        ], 
        5, 
        {}, 
        { 
          :use_tap_screen => false 
        }
      )
    """
  	Then the scenepos of Node is 180,280

#  @nodoc
#  Scenario: Perform gesture_points with :use_tap_screen as true - how to verify?
#    Given this scenario is pending

#  @nodoc
#  Scenario: Perform gesture with :isDrag as true - how to verify?
#    Given this scenario is pending

#  @nodoc
#  Scenario: Perform gesture with :isDrag as false - how to verify?
#    Given this scenario is pending

  @nodoc
  Scenario: (bugfix) Perform gesture with :press as false
    Given I launch application "testapp" as "@app"
  	And the Node is at location 200, 100
    When I execute
    """
      @app.Node.gesture_points(
        [
          {'x' => 220, 'y' => 120, 'interval' => 50},
          {'x' => 200, 'y' => 300, 'interval' => 40}
        ], 
        2.5, 
        { 
          :press => false, 
        }
      )
    """
  	Then the scenepos of Node is 200,100
  	And verify "@app.Node.attribute('color') == 'green'"

  @nodoc
  Scenario: (bugfix) Perform gesture with :press as false and :release as true
    Given I launch application "testapp" as "@app"
  	And the Node is at location 200, 100
    When I execute
    """
      @app.Node.gesture_points(
        [
          {'x' => 220, 'y' => 120, 'interval' => 50},
          {'x' => 200, 'y' => 300, 'interval' => 40}
        ], 
        2.5, 
        { 
          :press => false, 
          :release => true
        }
      )
    """
  	Then the scenepos of Node is 200,100
  	And verify "@app.Node.attribute('color') == 'green'"
  	
  @nodoc
  Scenario: (bugfix) Perform gesture with :press as true
    Given I launch application "testapp" as "@app"
  	And the Node is at location 200, 100
    When I execute
    """
      @app.Node.gesture_points(
        [
          {'x' => 220, 'y' => 120, 'interval' => 50},
          {'x' => 200, 'y' => 300, 'interval' => 40}
        ], 
        2.5, 
        { 
          :press => true, 
        }
      )
    """
  	Then the scenepos of Node is 180,280  	
  	And verify "@app.Node.attribute('color') == 'green'"

  @nodoc
  Scenario: (bugfix) Perform gesture with :press as true and :release as false
    Given I launch application "testapp" as "@app"
  	And the Node is at location 200, 100
    When I execute
    """
      @app.Node.gesture_points(
        [
          {'x' => 220, 'y' => 120, 'interval' => 50},
          {'x' => 200, 'y' => 300, 'interval' => 40}
        ], 
        2.5, 
        { 
          :press => true,
          :release => false 
        }
      )
    """
  	Then the scenepos of Node is 180,280
  	And verify "@app.Node.attribute('color') == 'yellow'"

