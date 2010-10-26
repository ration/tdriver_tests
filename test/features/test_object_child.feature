Feature: MobyBehaviour::TestObject#child
  As a test scripter writer
  I want to use child method to find test objects in calculator based on any attributes
  so that I can test the MobyBehaviour::TestObject behaviour

@pass
  Scenario: Testing child method with no argument
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child()"
    Then exception is thrown
    
@pass
  Scenario: Testing child method with required argument
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child(:text => 'Clear All')"
    Then a test object is found

@pass
  Scenario: Testing child method with ambiguous argument
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child(:type => 'Button')"
    Then exception matching "Multiple test objects found with rule" is thrown
    
@pass
  Scenario: Testing child method returns the same reference after each call
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child(:text => 'MC')"
    Then another test object with the same rule should be equal
    
