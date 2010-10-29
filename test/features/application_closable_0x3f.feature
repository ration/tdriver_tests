@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::Application#closable?
  As a test scripter writer
  I want to use closable? method to test if calculator is closable
  so that I can test the MobyBehaviour::Application behaviour


  Scenario: Testing closable? method
    Given I launch application "calculator" as "@app"
    When I execute "$closable = @app.closable?()"
    Then "$closable" is set to true

