@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Fps#start_fps_measurement
  As a test script writer
  I want to measure the frames per second for an object
  so that I can test the MobyBehaviour::QT::Fps behaviour

  Scenario: Start measuring fps for a view 
    Given I launch application "testapp" as "@app"
    Then I execute "@app.MainView( :name => 'MainView' ).start_fps_measurement"
    And I create some activity 
	Then I stop measuring fps data
	And I verify that fps results are collected
