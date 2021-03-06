@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#application?
  As a test scripter writer
  I want to use application? method to test of current test object is application in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing application? method
    Given I launch application "testapp" as "@app"
    When I execute "$isApp = @app.application?"
    Then verify "$isApp==true"

  Scenario: Testing application? method for testobject that is not an application
    Given I launch application "testapp" as "@app"
    When I execute "$isApp = @app.Triangle( :name => 'Triangle1' ).application?"
    Then verify "$isApp==false"

