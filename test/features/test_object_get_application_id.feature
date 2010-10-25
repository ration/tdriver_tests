Feature: MobyBehaviour::TestObject#get_application_id
  As a test scripter writer
  I want to use get_application_id method to retrieve the application id for a Test Object in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

@pass
  Scenario: Testing get_application_id method for application testapp
    Given I launch application "testapp" as "@app"
    And I get the application id for "@app"
    Then application id is id for test object "@app"
    
@pass
  Scenario: Testing get_application_id method for a Test Object in testapp
    Given I launch application "testapp" as "@app"
    When I execute "$triangle = @app.Triangle( :name => 'Triangle1' )"
    And I get the application id for "$triangle"
    Then application id is id for test object "@app"

