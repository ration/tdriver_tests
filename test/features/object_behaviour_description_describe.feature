@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::ObjectBehaviourDescription#describe
  As a test scripter writer
  I want to use describe method to obtain a list of methods and behaviour name(s) which object contains in testapp
  so that I can test the MobyBehaviour::ObjectBehaviourDescription behaviour

  Scenario: Testing describe method with default arguments, to print list of methods to screen
    Given I launch application "testapp" as "@app"
    When I execute "@app.Triangle( :name => 'Triangle1' ).describe()"
    Then exception is not thrown

  Scenario: Testing describe method with optional argument 'print' set to false, to return result as Hash
    Given I launch application "testapp" as "@app"
    When I execute "$result=@app.Triangle( :name => 'Triangle1' ).describe(false)"
    Then verify "$result.class==Hash && $result.size==3"

  Scenario: Testing describe method with optional arguments 'print' and 'return_result' set to true, to print and return result as string
    Given I launch application "testapp" as "@app"
    When I execute "$result=@app.Triangle( :name => 'Triangle1' ).describe(true, true)"
    Then verify "$result.class==String"

