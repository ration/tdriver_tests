@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#state
  As a test scripter writer
  I want to use state method to get the static state object in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing state method 
    Given I launch application "testapp" as "@app"
    When I execute "$app_state=@app.state()"
    Then "$app_state" is a static state object

