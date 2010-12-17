@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::ObjectBehaviourDescription#behaviours
  As a test scripter writer
  I want to use behaviours method to obtain list of behaviours in testapp
  so that I can test the MobyBehaviour::ObjectBehaviourDescription behaviour

  Scenario: Testing behaviours method with no arguments to obtain array of behaviour names
    Given I launch application "testapp" as "@app"
    When I execute "$behaviours=@app.behaviours"
    Then I obtain array of behaviour names

  Scenario: Testing behaviours method with optional argument 'return_indexes' set to true, to obtain array of indexes
    Given I launch application "testapp" as "@app"
    When I execute "$behaviours=@app.behaviours(true)"
    Then I obtain array of indexes

