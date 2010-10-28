@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Method#call_method
  As a test scripter writer
  I want to use call_method method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Method behaviour

  Scenario: Testing call_method method with a slot which does not take arguments
    Given I launch application "calculator"
    Then verify "@app.QLineEdit(:name => 'display').attribute('text') == '0'"
    When I execute "@app.QLineEdit(:name => 'display').call_method('clear()')"
    Then verify "@app.QLineEdit(:name => 'display').attribute('text').empty?"
