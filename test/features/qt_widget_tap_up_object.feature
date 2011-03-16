@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap_up_object
  As a test scripter writer
  I want to use tap_up_object method to release mouse on object in testapp
  so that I can test the MobyBehaviour::QT::Widget behaviour


  Scenario: Tapping up at child QGraphicsItem coordinates after having done tap_down on it
    Given I launch application "testapp"
    And I tap down on Triangle1
    Then color of Triangle1 is "darkMagenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_up_object( pos[0], pos[1] )
      """
    Then color of Triangle1 is "magenta"
    

@nodoc
  Scenario: Testing tap_up_object method with optional argument 'button' to use in press
    Given I launch application "testapp"
    And I tap down on Triangle1
    Then color of Triangle1 is "darkMagenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_up_object( pos[0], pos[1],:Right )
      """
    Then color of Triangle1 is "magenta"

@nodoc
  Scenario: Testing tap_up_object method with optional argument 'tap_params' 
    Given I launch application "testapp"
    And I tap down on Triangle1
    Then color of Triangle1 is "darkMagenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_up_object( pos[0], pos[1],:Right,{:tap_count=>2} )
      """
    Then color of Triangle1 is "magenta"

