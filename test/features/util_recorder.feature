@qt_linux @qt_windows @qt_symbian 

Feature: MobyUtil::Recorder#start_rec
  As a test scripter writer
  I want to use find method to find test objects in target application based on any attributes,
  so that I can test the MobyUtil::Recorder

@nodoc
  Scenario: Testing find method with no arguments
    Given I launch application "calculator" as "@app"
    And I start the recorder and do tap some buttons
    When I execute "@ruby_script = MobyUtil::Recorder.print_script( @__sut, @app )"
    Then I am able to play the correct ruby script

