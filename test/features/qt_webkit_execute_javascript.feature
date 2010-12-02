@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Webkit#execute_javascript
  As a test scripter writer
  I want to use execute_javascript method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: Testing execute_javascript method 
    Given I launch application "browser"
    When I execute "@app.p(:id => 'sample').execute_javascript('this.innerHTML=\'<div>tdriver evolves</div>\';')"
    Then I verify that "div" is having "elementText" with value "tdriver evolves"

  Scenario: Testing execute_javascript method's return value 
    Given I launch application "browser"
    When I execute 
    """
        calc = @app.p(:id=>'sample').execute_javascript('2+3;');
        @app.p(:id => 'sample').execute_javascript('this.innerHTML=\'<div>'+calc+'</div>\';')
    """
    Then I verify that "div" is having "elementText" with value "5"

