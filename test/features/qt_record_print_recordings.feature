@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Record#print_recordings
  As a test scripter writer
  I want to use print_recordings method to print recorded script in testapp 
  so that I can test the MobyBehaviour::QT::Record behaviour

  Scenario: Testing print_recordings method 
    Given I launch application "testapp" as "@app"
    And I start recording and perform some gestures
    When I execute "@script=MobyUtil::Recorder.print_script(@__sut, @app)"	
    Then I am able to play the recording

