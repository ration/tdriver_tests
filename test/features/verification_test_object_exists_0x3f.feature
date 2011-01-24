@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::Verification#test_object_exists?
  As a test scripter writer
  I want to use test_object_exists? method to check if test object matching criteria exists in calculator
  so that I can test the MobyBehaviour::Verification behaviour
  
  Scenario: Testing test_object_exists? method with required arguments
    Given I launch application "calculator" as "@app"
    When I execute "$obj_exists = @app.test_object_exists?( :type => 'Button')"
    Then verify "$obj_exists==true"

  Scenario: Testing test_object_exists? method with optional argument 'attributes'
    Given I launch application "calculator" as "@app"
    When I execute "$obj_exists = @app.test_object_exists?( :type => 'Button', :text => '+', :objectName => 'plusButton' )"
    Then verify "$obj_exists==true"

  Scenario: Testing test_object_exists? method with attributes for a test object that does not exists
    Given I launch application "calculator" as "@app"
    When I execute "$obj_exists = @app.test_object_exists?( :type => 'Button', :text => '+', :objectName => 'non_existing_object', :__timeout => 0 )"
    Then verify "$obj_exists==false"
