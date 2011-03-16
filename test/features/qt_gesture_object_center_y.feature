@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#object_center_y
  As a test scripter writer
  I want to use object_center_y method to get the y coordinate of the center of a object  in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: Testing object_center_y method
    Given I launch application "testapp" as "@app"
    When I execute "$center_y=@app.Node.object_center_y"
    Then verify "$center_y.to_i==@app.Node.attribute('height').to_i/2+@app.Node.attribute('y_absolute').to_i"
    
