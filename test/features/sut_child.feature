@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#child
  As a test scripter writer
  I want to use child method to find a child test object in testapp
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing child method to get test object from the sut with the given attributes
    Given I launch application "testapp" as "@app"
    When I execute "$testobj = @__sut.child(:name => 'testapp' )"
		Then a test object is found by child
