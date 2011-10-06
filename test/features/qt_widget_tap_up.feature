@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap_up
  As a test scripter writer
  I want to use tap_up method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Tapping up on a QGraphicsItem after having done tap_down on it
    Given I launch application "testapp"
    And I tap down on Triangle1
    Then color of Triangle1 is "darkMagenta"
    When I execute "@app.Triangle(:name => 'Triangle1').tap_up"
    Then color of Triangle1 is "magenta"

#@nodoc
#  Scenario: Testing tap_up method with optional argument 'button' (Rename this to be more descriptive)
#    Given I launch application [APPLICATION_NAME] as @app
#    When I execute "@app.[SOME_OBJECT].tap_up(button)"
#    Then [ADD_YOUR_VERIFICATION_HERE]

#@nodoc
#  Scenario: Testing tap_up method with optional argument 'refresh' (Rename this to be more descriptive)
#    Given I launch application [APPLICATION_NAME] as @app
#    When I execute "@app.[SOME_OBJECT].tap_up(button, refresh)"
#    Then [ADD_YOUR_VERIFICATION_HERE]

#@nodoc
#  Scenario: Testing tap_up method with optional argument 'tap_params' (Rename this to be more descriptive)
#    Given I launch application [APPLICATION_NAME] as @app
#    When I execute "@app.[SOME_OBJECT].tap_up(button, refresh, tap_params)"
#    Then [ADD_YOUR_VERIFICATION_HERE]

