@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#list_started_apps
  As a test scripter writer
  I want to use list_started_apps method to list applications started by qttasserver in target sut
  so that I can test the MobyBehaviour::QT::SUT behaviour


  # Scenario: Testing list_started_apps method after starting an app
  #   Given I have default sut
  #   And I launch application "calculator" as "@calculator"
  #   When I execute "@apps_testobject = MobyBase::StateObject.new(@sut.list_started_apps)"
  #   Then verify "@apps_testobject.application( :name => 'calculator', :__index => 0).attribute('startTime') != ''"

  # Scenario: Testing list_started_apps method after starting two apps
  #   Given I have default sut
  #   And I launch application "calculator" as "@calculator"
  #   And I launch application "testapp" as "@testapp"
  #   When I execute "@apps_testobject = MobyBase::StateObject.new(@sut.list_started_apps)"
  #   Then verify "@apps_testobject.application( :name => 'calculator', :__index => 0).attribute('startTime') != ''"
  #   And verify "@apps_testobject.application( :name => 'testapp', :__index => 0).attribute('startTime') != ''"
