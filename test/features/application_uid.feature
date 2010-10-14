Feature: MobyBehaviour::Application#uid
  As a test scripter writer
  I want to use uid method to get uid in calculator
  so that I can test the MobyBehaviour::Application behaviour

@pass
  Scenario: Testing uid method
    Given I launch application "calculator" as "@app"
    When I execute "$uid=@app.uid()"
    Then the uid is retrieved
