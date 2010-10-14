Feature: MobyBehaviour::Application#close
  As a test scripter writer
  I want to use close method to close calculator
  so that I can test the MobyBehaviour::Application behaviour

@pass
  Scenario: Testing close method with default arguments
    Given I launch application "calculator" as "@app"
    When I execute "@app.close()"
    Then application "calculator" is not running

@pass
  Scenario: Testing close method with optional argument force_close set to false
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :force_close => false )"
    Then application "calculator" is not running
		
@pass
	Scenario: Testing close method with optional argument force_close set to true
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :force_close => true )"
    Then application "calculator" is not running

@pass
	Scenario: Testing close method with optional argument check_process set to false
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :check_process => false )"
    Then application "calculator" is not running
