@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap_down_object
  As a test scripter writer
  I want to use tap_down_object method to tap object in testapp
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Tapping down at child QGraphicsItem coordinates
    Given I launch application "testapp"
    Then color of Triangle1 is "magenta"
    When I execute 
      """
      # retrieve position
      pos = @app.child(:name => 'Triangle1').attribute('pos').split(',').map{ | str | str.to_i + 5 }
       
      # perform tap down object
      @app.NodeView.tap_down_object(pos[ 0 ], pos[ 1 ])
      """
    Then color of Triangle1 is "darkMagenta"


@nodoc    
  Scenario: Testing tap_down_object method with optional argument 'button' to use.
    Given I launch application "testapp"
    Then color of Triangle1 is "magenta"
    When I execute 
      """
      # retrieve position
      pos = @app.child(:name => 'Triangle1').attribute('pos').split(',').map{ | str | str.to_i + 5 }
       
      # perform tap down object
      @app.NodeView.tap_down_object(pos[ 0 ], pos[ 1 ], :Right)
      """
    Then color of Triangle1 is "darkMagenta"

@nodoc    
  Scenario: Testing tap_down_object method with optional argument 'tap_params'
   Given I launch application "testapp"
    Then color of Triangle1 is "magenta"
    When I execute 
      """
      # retrieve position
      pos = @app.child(:name => 'Triangle1').attribute('pos').split(',').map{ | str | str.to_i + 5 }
       
      # perform tap down object
      @app.NodeView.tap_down_object( pos[ 0 ], pos[ 1 ] ,:Right, {:tap_count=>2})
      """
    Then color of Triangle1 is "darkMagenta"


