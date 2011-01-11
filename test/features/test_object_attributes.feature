@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#attributes
  As a test scripter writer
  I want to use attributes method to retrieve all test object attributes
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Executing attributes method to retrieve all test object attributes
    Given I launch application "testapp" as "@app"
    When I execute "$attributes = @app.Triangle( :name => 'Triangle1' ).attributes"
    Then the attributes are retrieved

