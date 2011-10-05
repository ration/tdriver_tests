@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Attribute#[]=
  As a test script writer
  I want to use set_attribute method to set object attributes in testapp
  so that I can test the MobyBehaviour::QT::Attribute behaviour

  Scenario: Set test object "x" attribute value
    Given I launch application "testapp" as "@app"
    When I execute "@app.Control('Crash')['x'] = 225"
    Then the Control with name Crash has the attribute Qt_x with the value 225

  Scenario: Set test object pos attribute value with 
    Given I launch application "testapp" as "@app"
    When I execute "@app.Control('Crash')['pos', 'QPoint'] = '10,10'"
    Then the Control with name Crash has the attribute pos with the value 10,10

