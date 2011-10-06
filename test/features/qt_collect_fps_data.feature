@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Fps#stop_fps_measurement
  As a test script writer
  I want to measure the frames per second for an object
  so that I can test the MobyBehaviour::QT::Fps behaviour

  Scenario: Stop measuring fps for a view. Results are returned in a hash
    Given I launch application "testapp" as "@app"
  	And I test code "@app.MainView(:name => 'MainView').start_fps_measurement"
    And I create some activity 
    Then I execute "@data_array = @app.MainView(:name => 'MainView').collect_fps_data"
  	And I verify that fps results are collected
