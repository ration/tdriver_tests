@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#application
  As a test scripter writer
  I want to use application method to get the foreground application in sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing application method
    Given I launch application "testapp" as "@app"
    When I execute "$app2=@__sut.application"
    Then verify "$app2==@app"

  Scenario: Testing application method with optional argument 'attributes'
    Given I launch application "testapp" as "@app"
    When I execute "$app2=@__sut.application( :name => 'testapp' )"
    Then verify "$app2==@app"
