Feature: MobyBehaviour::TestObject#attribute
  As a test scripter writer
  I want to use attribute method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing attribute method with attribute name
    Given I launch application "testapp" as "@app"
    When I execute "$color=@app.Triangle( :name => 'Triangle1' ).attribute('color')"
    Then "$color" is set to string "magenta"

	Scenario: Testing attribute method with attribute name that does not exist
    Given I launch application "testapp" as "@app"
    When I execute "$color=@app.Triangle( :name => 'Triangle1' ).attribute('non-existent')"
    Then exception is thrown
