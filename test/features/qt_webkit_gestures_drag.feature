@nodoc

Feature: Testing WebKit gesture features
  As a test scripter writer
  I want to check that the webkit gestures are working correctly
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: After loading gesture page blue element should be draggable
    Given I launch application "browser"
    Then I move to page "../html/drag.html"
    Then I verify that the page is loaded
    When I execute 
    """
        @app.div(:id => 'blue').gesture(:Down,4,40)
        @app.div(:id => 'blue').gesture(:Right,3,30)
        @app.div(:id => 'blue').gesture(:Up,2,20)
        @app.div(:id => 'blue').gesture(:Left,1,10)
    """
    Then I verify that "div" is having "x" with evaluated value "@app.html(:name=>'html').attribute('x').to_i+20"
    Then I verify that "div" is having "y" with evaluated value "@app.html(:name=>'html').attribute('y').to_i+420"
    
  Scenario: After loading gesture page blue element should be draggable
    Given I launch application "browser"
    Then I move to page "../html/drag.html"
    Then I verify that the page is loaded
    When I execute 
    """
        @app.div(:id => 'blue').drag(:Down,40)
        @app.div(:id => 'blue').drag(:Right,30)
        @app.div(:id => 'blue').drag(:Up,20)
        @app.div(:id => 'blue').drag(:Left,10)
    """
    Then I verify that "div" is having "x" with evaluated value "@app.html(:name=>'html').attribute('x').to_i+20"
    Then I verify that "div" is having "y" with evaluated value "@app.html(:name=>'html').attribute('y').to_i+420"

  Scenario: After loading gesture page blue element should gesture to target coordinates
    Given I launch application "browser"
    Then I move to page "../html/drag.html"
    Then I verify that the page is loaded
    When I execute "@app.div(:id => 'blue').gesture_to(100,100,3)"
    Then I verify that "div" is having "x" with evaluated value "@app.html(:name=>'html').attribute('x').to_i+100"
    Then I verify that "div" is having "y" with evaluated value "@app.html(:name=>'html').attribute('y').to_i+100"

  Scenario: After loading gesture page blue element should drag to target coordinates
    Given I launch application "browser"
    Then I move to page "../html/drag.html"
    Then I verify that the page is loaded
    When I execute "@app.div(:id => 'blue').drag_to(100,100)"
    Then I verify that "div" is having "x" with evaluated value "@app.html(:name=>'html').attribute('x').to_i+100"
    Then I verify that "div" is having "y" with evaluated value "@app.html(:name=>'html').attribute('y').to_i+100"

  Scenario: After loading gesture page blue element should dragable to red box
    Given I launch application "browser"
    Then I move to page "../html/drag.html"
    Then I verify that the page is loaded
    When I execute "@app.div(:id => 'blue').gesture_to_object(@app.div(:id=>'red'),2,{:button => :Left, :isDrag=>true})"
    Then I verify that "div" is having "x" with evaluated value "@app.div(:id=>'red').attribute('x').to_i+10"
    Then I verify that "div" is having "y" with evaluated value "@app.div(:id=>'red').attribute('y').to_i+10"

  Scenario: After loading gesture page blue element should be usable trough custom gestures
    Given I launch application "browser"
    Then I move to page "../html/drag.html"
    Then I verify that the page is loaded
    When I execute
    """
       @app.div(:id => 'blue').gesture_points(
         [{'x' => 77, 'y' => 93, 'interval' => 1 },
          {'x' => 100, 'y' => 100, 'interval' => 2 },
          {'x' => 25, 'y' => 83, 'interval' => 2 }
         ], 
         5,
         { :press => true, :release => true }
        )
    """
       
    Then I verify that "div" is having "x" with evaluated value "@app.html(:name=>'html').attribute('x').to_i+25"
    Then I verify that "div" is having "y" with evaluated value "@app.html(:name=>'html').attribute('y').to_i+83"

