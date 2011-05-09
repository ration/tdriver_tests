@qt_windows @qt_symbian

Feature: MobyBehaviour::QT::Fixture#fixture
  As a test scripter writer
  I want to use fixture feature to log properties from an object
  so that I can test the MobyBehaviour::QT::Fixture behaviour

  Scenario: Start to log properties from a list view component
    Given I launch application "hybrid_app" as "@app"
    When I start to log property verticalVelocity for object ContactList with interval 100
    And I gesture ContactList object Up for 600 pixels in 0.15 seconds 
    And I wait 5 second
    Then I use stopLogProperty to get property values for object ContactList property verticalVelocity

  Scenario: Continue to log properties from a list view component after fetching data
    Given I launch application "hybrid_app" as "@app"
    When I start to log property verticalVelocity for object ContactList with interval 100
    And I gesture ContactList object Up for 600 pixels in 0.15 seconds 
    And I wait 5 second
    Then I use logPropertyResults to get property values for object ContactList property verticalVelocity
    And I gesture ContactList object Up for 600 pixels in 0.15 seconds 
    And I wait 5 second 
    Then I use stopLogProperty to get property values for object ContactList property verticalVelocity
