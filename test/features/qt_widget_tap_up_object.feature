Feature: MobyBehaviour::QT::Widget#tap_up_object
  As a test scripter writer
  I want to use tap_up_object method to release mouse on object in testapp
  so that I can test the MobyBehaviour::QT::Widget behaviour

@qt_linux @qt_windows @qt_meego
  Scenario: Tapping up at child QGraphicsItem coordinates after having done tap_down on it
    Given I launch application "testapp"
    And I test code "@app.Triangle.tap_down_object(5,5)"
    Then color of Triangle1 is "darkMagenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_up_object( pos[0], pos[1] )
      """
    Then color of Triangle1 is "magenta"
    

@qt_linux @qt_windows @qt_meego @nodoc
  Scenario: Testing tap_up_object method with optional argument 'button' to use in press
    Given I launch application "testapp"
    And I test code "@app.Triangle.tap_down_object(5,5)"
    Then color of Triangle1 is "darkMagenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_up_object( pos[0], pos[1],:Right )
      """
    Then color of Triangle1 is "magenta"

@qt_linux @qt_windows @qt_meego @nodoc
  Scenario: Testing tap_up_object method with optional argument 'tap_params' 
    Given I launch application "testapp"
    And I test code "@app.Triangle.tap_down_object(5,5)"
    Then color of Triangle1 is "darkMagenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_up_object( pos[0], pos[1],:Left,{:tap_count=>2} )
      """
    Then color of Triangle1 is "magenta"


#with touch devices some mapping to the touch points is done to the item targeted so use tap screen 
#to send the touch to the device not the item.
@qt_symbian @nodoc
  Scenario: Tapping up at child QGraphicsItem coordinates after having done tap_down on it
    Given I launch application "testapp"
    And I test code "@app.Triangle.tap_down_object(5,5, :Left, { :use_tap_screen => 'true' })"
    Then color of Triangle1 is "darkMagenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_up_object( pos[0], pos[1], { :use_tap_screen => 'true' })
      """
    Then color of Triangle1 is "magenta"
    

@qt_symbian @nodoc
  Scenario: Testing tap_up_object method with optional argument 'button' to use in press
    Given I launch application "testapp"
    And I test code "@app.Triangle.tap_down_object(5,5, :Left,{ :use_tap_screen => 'true' })"
    Then color of Triangle1 is "darkMagenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_up_object( pos[0], pos[1],:Left, { :use_tap_screen => 'true' } )
      """
    Then color of Triangle1 is "magenta"

@qt_symbian @nodoc
  Scenario: Testing tap_up_object method with optional argument 'tap_params' 
    Given I launch application "testapp"
    And I test code "@app.Triangle.tap_down_object(5,5, :Left, { :use_tap_screen => 'true' })"
    Then color of Triangle1 is "darkMagenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_up_object( pos[0], pos[1],:Left,{:tap_count=>2, :use_tap_screen => 'true'} )
      """
    Then color of Triangle1 is "magenta"

