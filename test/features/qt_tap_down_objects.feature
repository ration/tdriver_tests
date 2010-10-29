@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Application#tap_down_objects
  As a test script writer
  I want to use tap_down_objects method to tap down multiple objects at the same time
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Execute tap_down_objects on 4 objects
    Given I launch application "matti_multitouchapp"
	And I press the next 2 times
    Then I execute "@app.tap_down_objects([@app.Square(:name =>'topLeft'), @app.Square(:name =>'topRight'), @app.Square(:name =>'lowRight'),@app.Square(:name =>'lowLeft')])"
    Then all squares have been pressed down
