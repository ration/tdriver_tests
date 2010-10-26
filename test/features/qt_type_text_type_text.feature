@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::TypeText#type_text
  As a test scripter writer
  I want to use type_text method to type text to a widget that accepts typed text
  so that I can test the MobyBehaviour::QT::TypeText behaviour

  Scenario: Testing type_text method on QLineEdit widget
    Given I launch application "calculator"
    And I set child "display" attribute "readOnly" to "false"
    Then The calculator display says "0"
    When I execute "@app.QLineEdit( :name => 'display' ).type_text( 'abc' )"
    Then The calculator display says "0abc"

