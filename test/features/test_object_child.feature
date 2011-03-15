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
    
  Scenario: Retrieving the child test object with given attributes
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child(:text => 'Clear All')"
    Then a test object is found by child

  @nodoc
  Scenario: Testing child method with ambiguous argument
    Given I launch application "calculator" as "@app"
    When I execute "$testobj = @app.child(:type => 'Button', :__timeout => 0)"
    Then exception type of "MobyBase::MultipleTestObjectsIdentifiedError" is thrown
    
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
    
  Scenario: Retrieve test object type of Button by using index attribute
    Given I launch application "calculator" as "@app"
    Then I verify that "Calculator" is having "x" with value "0"
    When I execute "@app.child(:type => 'Button', :__index => 16)"
    Then result test object is same as "@app.child(:type => 'Button', :text => '1')"

  @nodoc
  Scenario: Correct exception is raised when trying to retrieve non existing child test object from application object
    Given I launch application "calculator" as "@app"
    When I execute "@app.NonExistingChildTestObject(:__timeout => 0)"
    Then exception matching "The application" is thrown

  @nodoc
  Scenario: Correct exception is raised when trying to retrieve non existing child test object from test object
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:__index=>0, :__timeout => 0).NonExistingChildTestObject(:__timeout => 0)"
    Then exception matching "The test object" is thrown

  Scenario: Retrieving the test object with object name attribute as regular expression
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:name => /^oneButton$/)"
    Then exception is not thrown

  Scenario: Retrieving the test object with object name attribute as case insensitive regular expression
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:name => /^onebutton$/i)"
    Then exception is not thrown

  Scenario: Retrieving the test object with object name attribute as regular expression with multiple options
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:name => /^(one|Button|oneButton)$/)"
    Then exception is not thrown

  Scenario: Retrieving the test object with text attribute as regular expression with multiple options
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:text => /^(a|b|c|5)$/)"
    Then exception is not thrown

