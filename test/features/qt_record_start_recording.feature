@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Record#start_recording
  As a test scripter writer
  I want to use start_recording method to record gesture in testapp
  so that I can test the MobyBehaviour::QT::Record behaviour

  Scenario: Testing start_recording method
    Given I launch application "testapp" as "@app"
    When I execute "MobyUtil::Recorder.start_rec(@app)"
    And I perform some gestures and stop recording
    Then I am able to play the recording 

