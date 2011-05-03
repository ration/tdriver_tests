@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#list_apps
  As a test scripter writer
  I want to use list_apps method to list running testable applications in target sut
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing list_apps method with two applications open
    Given I have default sut
    And I launch application "calculator" as "@calculator"
    And I launch application "testapp" as "@testapp"
    When I execute "@apps_testobject = @sut.state_object( @sut.list_apps )"
    Then verify "nil != @apps_testobject.application( :name => 'calculator', :__index => 0)"
    And verify "nil != @apps_testobject.application( :name => 'testapp', :__index => 0)"
