Feature: MobyBehaviour::TestObject#attributes
  As a test scripter writer
  I want to use attributes method to retrieve all test object attributes
  so that I can test the MobyBehaviour::TestObject behaviour

@pass
  Scenario: Testing attributes method
    Given I launch application "testapp" as "@app"
    When I execute "$attributes = @app.Triangle( :name => 'Triangle1' ).attributes()"
    Then the attributes are retrieved

