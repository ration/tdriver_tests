@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::ObjectBehaviourDescription#describe_method
  As a test scripter writer
  I want to use describe_method method to obtain brief method description for a method for an object in testapp
  so that I can test the MobyBehaviour::ObjectBehaviourDescription behaviour

  Scenario: Testing describe_method method with required argument method name, to print description
    Given I launch application "testapp" as "@app"
    When I execute "@app.Triangle( :name => 'Triangle1' ).describe_method('type')"
    Then exception is not thrown

  Scenario: Testing describe_method method with optional argument 'print' set to false, to return result as Hash
    Given I launch application "testapp" as "@app"
    When I execute "$result=@app.Triangle( :name => 'Triangle1' ).describe_method('type', false)"
    Then verify "$result.class==Hash"

  Scenario: Testing describe_method method with optional arguments 'print' and 'return_result' set to true, to print and return result as string
    Given I launch application "testapp" as "@app"
    When I execute "$result=@app.Triangle( :name => 'Triangle1' ).describe_method('type',true,true)"
    Then verify "$result.class==String"

