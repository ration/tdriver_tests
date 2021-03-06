@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::QT::Events#get_events
  As a test scripter writer
  I want to use get_events method to get the events that were listened
  so that I can test the MobyBehaviour::QT::Events behaviour

  Scenario: Get the events that were collected with enable_events
	Given I launch application "calculator"
	And I start listening to events on button sevenButton
	And Tap button sevenButton
  When I execute " @app.Button(:name => 'sevenButton').get_events"
  Then the results of sevenButton should contain MouseButtonPress,MouseButtonRelease events
  And I test code "@app.Button(:name => 'sevenButton').disable_events"


  Scenario: Get the events that were collected with application startup parameter events_to_listen
	Given I launch application "testapp" with listening events "Paint"	
        When I execute "@app_events=@app.get_events"
        Then the application should have Paint events
        And I test code "@app.disable_events"

