@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Application#tap_objects
  As a test script writer
  I want to use tap_objects method to tap multiple objects at the same time
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Execute tap_objects on 4 objects
    Given I launch application "matti_multitouchapp"
	  And I press the next 2 times
    Then I execute "@app.tap_objects([@app.Square(:name =>'topLeft'), @app.Square(:name =>'lowLeft'),@app.Square(:name =>'topRight'),@app.Square(:name =>'lowRight')])"
    Then all squares have been pressed 1 times