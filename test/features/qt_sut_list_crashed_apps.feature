@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#list_crashed_apps
  As a test scripter writer
  I want to use list_crashed_apps method to list crashed applications  in testapp
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing list_crashed_apps method
    Given I launch application "testapp" as "@app"
    And I cause testapp to crash
    When I execute "$xml =@__sut.list_crashed_apps"
    Then crashed application name is "testapp" 