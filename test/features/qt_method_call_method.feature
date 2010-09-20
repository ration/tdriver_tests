@qt_linux @qt_windows @qt_symbian @qt_meego
@dev
Feature: TestObject::call_method
  As a test scripter writer,
  I want to use call_method behaviour to invoke any slot method in a QObject-derived testobject,
  so that I can prepare a scenario state more easily and faster than emulating user behaviour.

  Scenario: Testing call_method behaviour on valid QGraphicsWidget slot that takes no arguments
    Given I launch application "testapp"
    And I show FloatingMenu of the testapp
    When I execute "@app.Control( :name => 'AddRectangle' ).call_method('click()')"
    Then object named "Rectangle1" is visible on screen

  Scenario: Testing call_method behaviour on valid QWidget slot that takes no arguments
    Given I launch application "calculator"
    When I execute "@app.Button( :name => 'nineButton' ).call_method('click()')"
    Then The calculator display says "9"

  Scenario: Testing call_method behaviour on valid Application object slot that takes no arguments
    Given I launch application "calculator"
    Then application "calculator" is running    
    When I execute "@app.call_method('quit()')"
    Then application "calculator" is not running
