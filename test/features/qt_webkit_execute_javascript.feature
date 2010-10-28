Feature: MobyBehaviour::QT::Webkit#execute_javascript
  As a test scripter writer
  I want to use execute_javascript method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: Testing execute_javascript method 
    Given I launch application "testapp"
    Then I move to webkit screen
    When I execute "@app.p(:id => 'sample').execute_javascript('this.innerHTML=\'<a>tdriver evolves</a>\';')"
    Then I verify that "a" is having "elementText" with value "tdriver evolves"
  

  Scenario: Testing execute_javascript method's return value 
    Given I launch application "testapp"
    Then I move to webkit screen
    When I execute "calc = @app.p(:id=>'sample').execute_javascript('2+3;');@app.p(:id => 'sample').execute_javascript('this.innerHTML=\'<a>'+calc+'</a>\';')"
    Then I verify that "a" is having "elementText" with value "5"

