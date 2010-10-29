@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Events#disable_events
  As a test scripter writer
  I want to use disable_events method stop listening to events
  so that I can test the MobyBehaviour::QT::Events behaviour

  Scenario: Stop listening to mouse events
	Given I launch application "calculator"
    When I execute "@app.Button(:name => 'sevenButton').disable_events()"
    Then I cannot get events for sevenButton

