@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#get_application_id
  As a test scripter writer
  I want to use get_application_id method to get the application id  for object in testapp
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing get_application_id method with required argument(s) (Rename this to be more descriptive)
    Given I launch application "testapp" as "@app"
    When I execute "$app_id=@__sut.get_application_id"
    Then verify "$app_id==@app.id"

 