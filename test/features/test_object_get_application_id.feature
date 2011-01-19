@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#get_application_id
  As a test scripter writer
  I want to use get_application_id method to retrieve the application id for a Test Object in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing get_application_id method for application testapp
    Given I launch application "testapp" as "@app"
    When I execute "$application_id = @app.get_application_id"
    Then verify "@app.id==$application_id"

    
  Scenario: Testing get_application_id method for a Test Object in testapp
    Given I launch application "testapp" as "@app"
    When I execute "$application_id = @app.Triangle( :name => 'Triangle1' ).get_application_id"
    Then verify "@app.id==$application_id"

