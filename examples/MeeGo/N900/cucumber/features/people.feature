@qt_meego
Feature: Add Contact Into People Application
  As a test script writer
  I Want to test the meego peoples app
  so that I add a contact into the application

  Scenario: Add Contact
    Given I launch application meego-handset-people
    And I tap text "People"
    And I tap text "Add Contact"
    And I type "Tom" to field "First name"
    And I type "Tester" to field "Last name"
    And I tap text "<b>+ Add a Number</b>"
    And I type "+1234577" to field "Phone number"
    Then I see text "+1234577"
    And I flick up from "Telephone numbers"
    And I tap text "<b>+ Add an Email</b>"
    And I type "tom.tester@invalid.com" to field "Email address"  
    And I tap text "Add Contact"
    And I tap text "<b>Save</b>"
    Then I see text "Tom Tester" 
    Then I close the application