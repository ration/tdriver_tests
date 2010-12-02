@qt_linux @qt_windows @qt_meego

Feature: MobyBehaviour::QT::KeyPress#press_key
  As a test scripter writer
  I want to use press_key method to send a key press to the application
  so that I can test the MobyBehaviour::QT::KeyPress behaviour

  Scenario: Using press_key with a Ruby symbol argument
    Given I launch application "testapp"
    Then testapp nonModalPopup button is not visible on screen
    When I execute "@app.NodeView.press_key(:kRight)"
    Then testapp nonModalPopup button is visible on screen
		
  Scenario: Using press_key with a hex argument
    Given I launch application "testapp"
    Then testapp nonModalPopup button is not visible on screen
    When I execute "@app.NodeView.press_key(0x01000014)"
    Then testapp nonModalPopup button is visible on screen
