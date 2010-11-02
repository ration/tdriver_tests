@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Application#drag
  As a test scripter writer
  I want to use drag method to drag the pointer in testapp
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Testing drag method with required argument(s) (Rename this to be more descriptive)
    Given I launch application "testapp"
    When I execute "@app.drag( ix = @app.Node(:name => 'Node1').attribute("x").to_i, iy = @app.Node(:name => 'Node1').attribute("y").to_i, ix - 10, iy - 10)"
    Then exception is not thrown

  Scenario: Testing drag method with optional argument 'duration' (Rename this to be more descriptive)
    Given I launch application "testapp"
    When I execute "@app.drag( ix = @app.Node(:name => 'Node1').attribute("x").to_i, iy = @app.Node(:name => 'Node1').attribute("y").to_i, ix - 10, iy - 10, 2000)"
    Then exception is not thrown