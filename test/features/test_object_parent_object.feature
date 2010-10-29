@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#parent_object
  As a test scripter writer
  I want to use parent_object method to get the  object that was used as parent when the test object was created in calculator
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing parent_object method for an application object
    Given I launch application "calculator" as "@app"
    When I execute "@__sut.application( :name => 'calculator' ).parent"
    Then the parent object is the sut

  Scenario: Testing parent_object for a Test Object
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button( :text => '1' ).parent"
    Then the parent object is the app
