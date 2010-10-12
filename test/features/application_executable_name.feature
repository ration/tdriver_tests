Feature: MobyBehaviour::Application#executable_name
  As a test scripter writer
  I want to use executable_name method to get the executable name in calculator
  so that I can test the MobyBehaviour::Application behaviour

@pass @local
  Scenario: Testing executable_name method
    Given I launch application "calculator" as "@app"
    When I execute "$executable_name = @app.executable_name()"
    Then the application executable name should be "calculator"