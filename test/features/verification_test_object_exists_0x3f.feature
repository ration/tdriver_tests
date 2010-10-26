Feature: MobyBehaviour::Verification#test_object_exists?
  As a test scripter writer
  I want to use test_object_exists? method to check if test object matching criteria exists in calculator
  so that I can test the MobyBehaviour::Verification behaviour
  
@pass
  Scenario: Testing test_object_exists? method with required arguments
    Given I launch application "calculator" as "@app"
    When I execute "$obj_exists=@app.test_object_exists?('Button')"
    Then "$obj_exists" is set to true

@pass
  Scenario: Testing test_object_exists? method with optional argument 'attributes'
    Given I launch application "calculator" as "@app"
    When I execute "$obj_exists=@app.test_object_exists?('Button',{:text => '+',:objectName => 'plusButton'})"
    Then "$obj_exists" is set to true

@pass
  Scenario: Testing test_object_exists? method with attributes for a test object that does not exists
    Given I launch application "calculator" as "@app"
    When I execute "$obj_exists=@app.test_object_exists?('Button',{:text => '+',:objectName => 'plusButtonns'})"
    Then "$obj_exists" is set to false
