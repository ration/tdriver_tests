@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#attribute
  As a test scripter writer
  I want to use attribute method to get attributes for Test Objects in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Retrieving Triangle test object's "color" attribute 
    Given I launch application "testapp" as "@app"
    When I execute "$color = @app.Triangle(:name => 'Triangle1').attribute('color')"
    Then verify "$color=='magenta'"

  @nodoc
	Scenario: Testing attribute method with attribute name that does not exist
    Given I launch application "testapp" as "@app"
    When I execute "$color = @app.Triangle(:name => 'Triangle1').attribute('non-existent')"
    Then exception is thrown

  @nodoc    
	Scenario: Feature test for application argument attribute, testapp started without arguments
    Given I launch application "testapp" as "@app"
    When verify "@app.attribute('arguments').include?('testapp')"
    Then exception is not thrown
    
  @nodoc    
	Scenario: Feature test for application argument attribute, testapp started with arguments
    Given I have default sut
    When I execute "@app = @sut.run(:name=>'testapp', :arguments=>'--help')"
    And verify "@app.attribute('arguments').include?('--help')"
    Then exception is not thrown
