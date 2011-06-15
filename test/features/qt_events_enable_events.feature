@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::QT::Events#enable_events
  As a test scripter writer
  I want to use enable_events method to listen to events on the device
  so that I can test the MobyBehaviour::QT::Events behaviour

  Scenario: Listen to mouse events on a button in an application 
	Given I launch application "calculator"
  When I execute "@app.Button(:name => 'sevenButton').enable_events('ALL')"
  And Tap button sevenButton
  Then the results of sevenButton should contain MouseButtonPress,MouseButtonRelease events
  And I test code "@app.Button(:name => 'sevenButton').disable_events"

  Scenario: Listen to mouse events on a button in an application 
	Given I launch application "calculator"
  When I execute "@app.Button(:name => 'sevenButton').enable_events('MouseButtonRelease')"
  And Tap button sevenButton
  Then the results of sevenButton should contain MouseButtonRelease events
  Then the results of sevenButton should not contain MouseButtonPress events
  And I test code "@app.Button(:name => 'sevenButton').disable_events"
