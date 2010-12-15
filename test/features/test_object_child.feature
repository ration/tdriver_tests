@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#child
  As a test scripter writer
  I want to use child method to find test objects in calculator based on any attributes
  so that I can test the MobyBehaviour::TestObject behaviour

  @nodoc
  Scenario: Testing child method with no argument
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child()"
    Then exception is thrown
    
  Scenario: Testing child method with required argument
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child(:text => 'Clear All')"
    Then a test object is found by child

  @nodoc
  Scenario: Testing child method with ambiguous argument
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child(:type => 'Button', :__timeout => 0)"
    Then exception matching "Multiple test objects found with rule" is thrown
    
  @nodoc
  Scenario: Testing child method returns the same reference after each call
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child(:text => 'MC')"
    Then another test object with the same rule should be equal
    
  Scenario: Testing child method with xy_sorting feature
    Given I launch application "calculator" as "@app"
    When I execute "@app.child(:type => 'Button', :__xy_sorting => true, :__index => 16)"
    Then result test object is same as "@app.child(:type => 'Button', :text => '1')"
