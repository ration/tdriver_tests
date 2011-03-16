@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Record#stop_recording
  As a test scripter writer
  I want to use stop_recording method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Record behaviour

  Scenario: Testing stop_recording method with required argument(s) (Rename this to be more descriptive)
    Given I launch application "testapp" as "@app"
    And I start recording and perform some gestures
    And I print the recording
    When I execute "@script=@app.stop_recording"	
    Then I am able to play the recording

