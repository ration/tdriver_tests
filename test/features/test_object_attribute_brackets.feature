@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#[]
  As a test scripter writer
  I want to use attribute method to get attributes for Test Objects in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Retrieving test object's color attribute 
    Given I launch application "testapp" as "@app"
    When I execute "attribute = @app.Triangle('Triangle1')['color']"
    Then verify "@__ret_val=='magenta'"

  Scenario: Retrieving all test object's attributes
    Given I launch application "testapp" as "@app"
    When I execute "attributes = @app.Triangle(:name => 'Triangle1')[]"
    Then verify "@__ret_val.kind_of?( Hash ) && @__ret_val.has_key?( 'color' )"

  @nodoc
	Scenario: Testing attribute method with attribute name that does not exist
    Given I launch application "testapp" as "@app"
    When I execute "color = @app.Triangle('Triangle1')['non-existent']"
    Then exception is thrown

  @nodoc    
	Scenario: Feature test for application arguments attribute, testapp started without arguments
    Given I launch application "testapp" as "@app"
    When verify "@app['arguments'].include?('testapp')"
    Then exception is not thrown
    
  @nodoc    
	Scenario: Feature test for application argument attribute, testapp started with arguments
    Given I have default sut
    When I execute "@app = @sut.run(:name=>'testapp', :arguments=>'--help')"
    And verify "@app['arguments'].include?('--help')"
    Then exception is not thrown
