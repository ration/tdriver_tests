@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#child
  As a test scripter writer
  I want to use child method to find test objects in calculator based on any attributes
  so that I can test the MobyBehaviour::TestObject behaviour

  @nodoc
  Scenario: Testing child method with no argument
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child"
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

  @nodoc
  Scenario: Retrieving test object with empty attribute value (bugfix)
    Given I launch application "testapp" as "@app"
    When I execute "@app.Node(:emptyProp => '', :__timeout => 0)"
    Then exception is not thrown
    
  Scenario: Retrieve test object type of "Button" by using index feature
    Given I launch application "calculator" as "@app"
    Then I verify that "Calculator" is having "x" with value "0"
    When I execute "@app.child(:type => 'Button', :__index => 16)"
    Then result test object is same as "@app.child(:type => 'Button', :text => '1')"

  @nodoc
  Scenario: Correct exception is raised when trying to retrieve non existing child test object from application object
    Given I launch application "testapp" as "@app"
    When I execute "@app.NonExistingChildTestObject(:__timeout => 0)"
    Then exception matching "The application" is thrown

  @nodoc
  Scenario: Correct exception is raised when trying to retrieve non existing child test object from test object
    Given I launch application "testapp" as "@app"
    When I execute "@app.Node(:__index=>0, :__timeout => 0).NonExistingChildTestObject(:__timeout => 0)"
    Then exception matching "The test object" is thrown

