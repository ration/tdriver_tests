@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Widget#move_mouse
  As a test scripter writer
  I want to use move_mouse method to move the mouse to the centre of test object it was called on in testapp
  so that I can test the MobyBehaviour::QT::Widget behaviour

  Scenario: Testing move_mouse method without refreshing ui state
    Given I launch application "testapp" as "@app"
    When I execute "@app.Triangle(:name =>'Triangle1').move_mouse"
    And exception is not thrown

  Scenario: Testing move_mouse method and refreshing ui state
    Given I launch application "testapp" as "@app"
    When I execute "@app.Triangle(:name =>'Triangle1').move_mouse(true)"
    And exception is not thrown

