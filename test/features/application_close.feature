@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::Application#close
  As a test scripter writer
  I want to use close method to close calculator
  so that I can test the MobyBehaviour::Application behaviour

  Scenario: Testing close method with default arguments
    Given I launch application "calculator" as "@app"
    When I execute "@app.close"
    Then application "calculator" is not running

  Scenario: Testing close method with optional argument force_kill set to false
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :force_kill => false )"
    Then application "calculator" is not running
		
	Scenario: Testing close method with optional argument force_kill set to true
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :force_kill => true )"
    Then application "calculator" is not running

  @nodoc
  Scenario: Testing close method with false as argument (force_kill)
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( false )"
    Then application "calculator" is not running
		
  @nodoc
	Scenario: Testing close method with true as argument (force_kill)
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( true )"
    Then application "calculator" is not running

	Scenario: Testing close method with optional argument check_process set to false
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :check_process => false )"
    Then application "calculator" is not running

	Scenario: Testing close method with optional argument check_process set to true
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :check_process => true )"
    Then application "calculator" is not running
    
  @nodoc
  Scenario: Testing close method with optional argument force_kill set to "false" (string)
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :force_kill => 'false' )"
    Then application "calculator" is not running
		
  @nodoc
	Scenario: Testing close method with optional argument force_kill set to "true" (string)
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :force_kill => 'true' )"
    Then application "calculator" is not running

  @nodoc
  Scenario: Testing close method with "false" as argument (force_kill)
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( 'false' )"
    Then application "calculator" is not running
		
  @nodoc
	Scenario: Testing close method with "true" as argument (force_kill)
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( 'true' )"
    Then application "calculator" is not running

  @nodoc
	Scenario: Testing close method with optional argument check_process set to "false" (string)
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :check_process => 'false' )"
    Then application "calculator" is not running
    
  @nodoc
	Scenario: Testing close method with optional argument check_process set to "true" (string)
    Given I launch application "calculator" as "@app"
    When I execute "@app.close( :check_process => 'true' )"
    Then application "calculator" is not running
