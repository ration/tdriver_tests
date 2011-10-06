@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#tap_down
  As a test scripter writer
  I want to use tap_down method to tap object in testapp
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Tapping down on a QGraphicsItem
    Given I launch application "testapp"
    Then color of Triangle1 is "magenta"
    When I execute "@app.Triangle(:name => 'Triangle1').tap_down"
    Then color of Triangle1 is "darkMagenta"

@nodoc
  Scenario: Testing tap_down method with optional argument 'button'
    Given I launch application "testapp"
    Then color of Triangle1 is "magenta"
    When I execute "@app.Triangle(:name => 'Triangle1').tap_down(:Right)"
    Then color of Triangle1 is "darkMagenta"

@nodoc
  Scenario: Testing tap_down method with optional argument 'refresh' 
   Given I launch application "testapp"
    Then color of Triangle1 is "magenta"
    When I execute "@app.Triangle(:name => 'Triangle1').tap_down(:Right, true)"
    Then color of Triangle1 is "darkMagenta"

@nodoc
  Scenario: Testing tap_down method with optional argument 'tap_params'
    Given I launch application "testapp"
    Then color of Triangle1 is "magenta"
    When I execute "@app.Triangle(:name => 'Triangle1').tap_down(:Right, true, {:tap_count=>2})"
    Then color of Triangle1 is "darkMagenta"

