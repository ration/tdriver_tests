Feature: MobyBehaviour::QT::Application#change_orientation
  As a test scripter writer
  I want to use change_orientation method to change the orientation of the application
  so that I can test the MobyBehaviour::QT::Application behaviour

@qt_linux @qt_windows
Scenario: Change orientation using the change_orientation method
    Given I launch application "hybrid_app" as "@app"
	And I store dimensions for app
    When I execute "@app.change_orientation"
	Then application dimensions have switched
	And I store dimensions for app
	Then I test code "@app.change_orientation"
	Then application dimensions have switched

