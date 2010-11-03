@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#attribute
  As a test scripter writer
  I want to use attribute method to get attributes for Test Objects in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing attribute method with required argument
    Given I launch application "testapp" as "@app"
    When I execute "$color = @app.Triangle( :name => 'Triangle1' ).attribute('color')"
    Then verify "$color=='magenta'"

	Scenario: Testing attribute method with attribute name that does not exist
    Given I launch application "testapp" as "@app"
    When I execute "$color = @app.Triangle( :name => 'Triangle1' ).attribute('non-existent')"
    Then exception is thrown
