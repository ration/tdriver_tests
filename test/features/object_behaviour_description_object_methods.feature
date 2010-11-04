@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::ObjectBehaviourDescription#object_methods
  As a test scripter writer
  I want to use object_methods method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::ObjectBehaviourDescription behaviour

  Scenario: Testing object_methods method with required argument(s) (Rename this to be more descriptive)
    Given I launch application "testapp" as "@app"
    When I execute "$methods_array=@app.Triangle( :name => 'Triangle1' ).object_methods()"
    Then verify "$methods_array.class==Array"

