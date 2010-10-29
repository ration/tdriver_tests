@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Application#verify_popup
  As a test scripter writer
  I want to use verify_popup method to detect popups shown on screen.
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Get popup verification data as an xml object. Attributes (e.g @xml_object.PopupItem.attribute('text')) can be verified as with any test object.
	Given I launch application "testapp"
    And I hide the triangle
    And I hide the node
    And I go to popup view
	And I start to track PopupItem
	And I tap "modalPopup" control button
    When I execute "@xml_object = @app.verify_popup('PopupItem')"
   	Then I verify that the popup data is in the xml


  Scenario: Get popup verification data as an xml object with a specific timeout.
	Given I launch application "testapp"
    And I hide the triangle
    And I hide the node
    And I go to popup view
	And I start to track PopupItem
	And I tap "modalPopup" control button
    When I execute "@xml_object = @app.verify_popup('PopupItem', 10)"
   	Then I verify that the popup data is in the xml

