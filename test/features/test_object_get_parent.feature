Feature: MobyBehaviour::TestObject#get_parent
  As a test scripter writer
  I want to use get_parent method to get parent Test Object in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

@pass
  Scenario: Testing get_parent method for testapp
    Given I launch application "testapp" as "@app"
    And I get the parent for "@app"
    Then the parent test object is "@app"

@pass
  Scenario: Testing get_application method for a Test Object in testapp
    Given I launch application "testapp" as "@app"
    When I execute "$node = @app.Node( :name => 'Node1' )"
    And I get the parent for "$node"
    Then the parent test object is "@app.NodeView( :name => 'NodeArea' )"