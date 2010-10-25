Feature: MobyBehaviour::TestObject#application?
  As a test scripter writer
  I want to use application? method to test of current test object is application in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

@pass
  Scenario: Testing application? method
    Given I launch application "testapp" as "@app"
    When I execute "$isApp = @app.application?()"
    Then "$isApp" is set to true

@pass
  Scenario: Testing application? method for testobject that is not an application
    Given I launch application "testapp" as "@app"
    When I execute "$isApp = @app.Triangle( :name => 'Triangle1' ).application?()"
    Then "$isApp" is set to false

