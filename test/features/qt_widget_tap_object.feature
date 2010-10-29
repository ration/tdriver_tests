@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap_object
  As a test scripter writer
  I want to use tap_object method to tap objects at cetain coordinates in testapp application
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Tap at a child QGraphicsItem coordinates
    Given I launch application "testapp"
    And I show FloatingMenu of the testapp
    Then object named "Node2" does not exist
    When I execute 
      """
        pos = @app.Control( :name => 'AddNode').attribute('pos').split(',').map { |str| str.to_i + 5 }
        @app.Menu.tap_object( pos[0], pos[1] )
      """
    Then object named "Node2" is visible

@nodoc
  Scenario: Testing tap_object method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [ ] as @app
    When I execute "@app.[ ].tap_object(x, y)"
    Then [ ]
    
@nodoc
  Scenario: Testing tap_object method with optional argument 'tap_count' (Rename this to be more descriptive)
    Given I launch application [ ] as @app
    When I execute "@app.[ ].tap_object(x, y, tap_count)"
    Then [ ]

@nodoc
  Scenario: Testing tap_object method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [ ] as @app
    When I execute "@app.[ ].tap_object(x, y, tap_count, button)"
    Then [ ]

@nodoc
  Scenario: Testing tap_object method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application [ ] as @app
    When I execute "@app.[ ].tap_object(x, y, tap_count, button, tap_params)"
    Then [ ]

