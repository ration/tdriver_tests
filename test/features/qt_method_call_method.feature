@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Method#call_method
  As a test scripter writer
  I want to use call_method method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Method behaviour

  Scenario: Testing call_method method with a slot which does not take arguments
    Given I launch application "calculator"
    Then verify "@app.QLineEdit(:name => 'display').attribute('text') == '0'"
    When I execute "$val = @app.QLineEdit(:name => 'display').call_method('clear()')"
    Then verify "@app.QLineEdit(:name => 'display').attribute('text').empty?"
    Then verify "$val == ''"

  Scenario: Testing call_method method with invalid method
    Given I launch application "calculator"
    Then verify "@app.QLineEdit(:name => 'display').attribute('text') == '0'"
    When I execute "$val = @app.QLineEdit(:name => 'display').call_method('notClear()')"
    Then exception is thrown

  Scenario: Testing call with to setText
    Given I launch application "calculator"
    When I execute "@app.QLineEdit(:name => 'display').call_method('setText(const QString&)', 'hello, world!')"
    Then verify "@app.QLineEdit(:name => 'display').attribute('text') == 'hello, world!'" 

  Scenario: Testing multiple parameters in slot call
    Given I launch application "testapp"
    When I execute "$val = @app.Node.call_method('sumTest(int, double)', 10, 11.0).to_f"
    Then verify "$val == 21.0"

  Scenario: Testing multiple parameters in slot call, doubles
    Given I launch application "testapp"
    When I execute "$val = @app.Node.call_method('doubleTest(double, double)', 21.0,7.0).to_f"
    Then verify "$val == 3.0"

  Scenario: Testing boolean 
    Given I launch application "testapp"
    When I execute "$val = @app.Node.call_method('inverse(bool)', true)"
    Then verify "$val == 'false'"



