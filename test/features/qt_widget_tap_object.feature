Feature: MobyBehaviour::QT::Widget#tap_object
  As a test scripter writer
  I want to use tap_object method to tap objects at cetain coordinates in testapp application
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing tap_object method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [ ] as @app
    When I execute "@app.[ ].tap_object(x, y)"
    Then [ ]

  Scenario: Testing tap_object method with optional argument 'tap_count' (Rename this to be more descriptive)
    Given I launch application [ ] as @app
    When I execute "@app.[ ].tap_object(x, y, tap_count)"
    Then [ ]

  Scenario: Testing tap_object method with optional argument 'button' (Rename this to be more descriptive)
    Given I launch application [ ] as @app
    When I execute "@app.[ ].tap_object(x, y, tap_count, button)"
    Then [ ]

  Scenario: Testing tap_object method with optional argument 'tap_params' (Rename this to be more descriptive)
    Given I launch application [ ] as @app
    When I execute "@app.[ ].tap_object(x, y, tap_count, button, tap_params)"
    Then [ ]

