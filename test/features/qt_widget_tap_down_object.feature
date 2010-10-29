@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap_down_object
  As a test scripter writer
  I want to use tap_down_object method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Tapping down at child QGraphicsItem coordinates
    Given I launch application "testapp"
    Then color of Triangle1 is "magenta"
    When I execute 
      """
        pos = @app.child( :name => 'Triangle1').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.NodeView.tap_down_object( pos[0], pos[1] )
      """
    Then color of Triangle1 is "darkMagenta"

@nodoc    
  Scenario: Testing tap_down_object method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_down_object(x, y)"
    Then [ADD_YOUR_VERIFICATION_HERE]

@nodoc    
  Scenario: Testing tap_down_object method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_down_object(x, y, button)"
    Then [ADD_YOUR_VERIFICATION_HERE]

@nodoc    
  Scenario: Testing tap_down_object method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].tap_down_object(x, y, button, tap_params)"
    Then [ADD_YOUR_VERIFICATION_HERE]

