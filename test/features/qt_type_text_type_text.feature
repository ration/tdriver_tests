# Work started by AH
Feature: MobyBehaviour::QT::TypeText#type_text
  As a test scripter writer
  I want to use type_text method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::TypeText behaviour

  Scenario: Testing type_text method with required argument(s) (Rename this to be more descriptive)
    Given I launch application "calculator"
    And I set child "display" attribute "readOnly" to "false"
    Then The calculator display says "0"
    When I execute "@app.QLineEdit( :name => 'display' ).type_text( 'abc' )"
    Then The calculator display says "0abc"

