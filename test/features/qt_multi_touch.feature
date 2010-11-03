@qt_linux @qt_windows @qt_meego @qt_symbian
Feature: MobyBehaviour::QT::Application#multi_touch
  As a test script writer
  I want to use multi_touch method to perform multiple ui operation at the same time
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Execute multi touch tap operation
    Given I launch application "matti_multitouchapp"
	And I press the next 2 times
    Then I execute "@app.multi_touch{@app.Square(:name =>'topLeft').tap;@app.Square(:name =>'topRight').tap;@app.Square(:name =>'lowRight').tap;@app.Square(:name =>'lowLeft').tap}"
 	And all squares have been pressed 1 times

  Scenario: Execute multi touch gesture operation with two basic gestures
    Given I launch application "matti_multitouchapp"
	And I press the next 3 times
    Then I execute "@app.multi_touch{@app.MultiGestureView.gesture(:Right, 2, 150);@app.MultiGestureView.gesture(:Left, 2, 150)}"
 	Then 2 horizontal 150 pixel lines appear on the screen

  Scenario: Execute multi touch gesture operation with two pinch zooms
    Given I launch application "matti_multitouchapp"
	And I press the next 3 times
    Then I execute "@app.multi_touch{@app.MultiGestureView.pinch_zoom_in(2, 150, :Vertical,0);@app.MultiGestureView.pinch_zoom_out(2, 150, :Horizontal,0)}"
 	Then a 300 pixel cross figure should be drawn on the screen
	
  Scenario: Execute multi touch gesture operation with two rotations
    Given I launch application "matti_multitouchapp"
	And I press the next 3 times
    Then I execute "@app.multi_touch{@app.MultiGestureView.two_point_rotate(100, 0, :Clockwise, 90, 2);@app.MultiGestureView.two_point_rotate(100, 270, :Clockwise, 90, 2)}"
 	Then a 200 pixel circle should be drawn on the screen

		
