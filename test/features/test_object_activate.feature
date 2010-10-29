@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#activate
  As a test scripter writer
  I want to use activate method to activate a Test Object in testapp
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing activate method
    Given I launch application "testapp" as "@app"
    When I execute "@app.Node( :name => 'Node1' ).activate()"
    Then exception is not thrown

