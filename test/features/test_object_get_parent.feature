@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#get_parent
  As a test scripter writer
  I want to use get_parent method to get parent Test Object in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing get_parent method for testapp
    Given I launch application "testapp" as "@app"
    When I execute "$parent = @app.get_parent()"
    Then verify "$parent==@app"

  Scenario: Testing get_application method for a Test Object in testapp
    Given I launch application "testapp" as "@app"
    When I execute "$parent = @app.Node( :name => 'Node1' ).get_parent()"
    Then verify "$parent==@app.NodeView( :name => 'NodeArea' )"
