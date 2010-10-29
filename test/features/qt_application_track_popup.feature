Feature: MobyBehaviour::QT::Application#track_popup
  As a test scripter writer
  I want to use track_popup method to track that popup items are shown
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Track a modal dialog using the track popup behaviour
	Given I launch application "testapp"
    And I hide the triangle
    And I hide the node
    And I go to popup view
    When I execute "@app.track_popup('PopupItem')"
	And I tap "modalPopup" control button
	Then I verify that the popup was shown

  Scenario: Track a non modal dialog using the track popup behaviour (no difference to modal)
	Given I launch application "testapp"
    And I hide the triangle
    And I hide the node
	And I go to popup view
    When I execute "@app.track_popup('PopupItem')"
	And I tap "nonModalPopup" control button
	Then I verify that the popup was shown

