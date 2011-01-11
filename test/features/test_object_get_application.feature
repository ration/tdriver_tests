@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#get_application
  As a test scripter writer
  I want to use get_application method to retrieve the application object for a Test Object in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing get_application method for application testapp
    Given I launch application "testapp" as "@app"
    When I execute "$application = @app.get_application()"
    Then verify "$application==@app"

  Scenario: Testing get_application method for a test object in testapp
    Given I launch application "testapp" as "@app"
    When I execute "$application = @app.Triangle( :name => 'Triangle1' ).get_application()"
    Then verify "$application==@app"
