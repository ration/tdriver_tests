Feature: MobyBehaviour::TestObject#attribute
  As a test scripter writer
  I want to use attribute method to get attributes for Test Objects in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

@pass
  Scenario: Testing attribute method with required argument
    Given I launch application "testapp" as "@app"
    When I execute "$color = @app.Triangle( :name => 'Triangle1' ).attribute('color')"
    Then "$color" is set to string "magenta"

@pass
	Scenario: Testing attribute method with attribute name that does not exist
    Given I launch application "testapp" as "@app"
    When I execute "$color = @app.Triangle( :name => 'Triangle1' ).attribute('non-existent')"
    Then exception is thrown
