@qt_linux @qt_windows @qt_meego

Feature: MobyBehaviour::QT::Multitouch#pinch_zoom_in
  As a test script writer
  I want to use pinch zoom method to simulate effect of user doing a pinch zoom operation,
  so that I can test the MobyBehaviour::QT::Multitouch behaviour

  Scenario: Execute pinch_zoom_in method so that the pinch motion is vertical (fingers move up and down)
    Given I launch application "matti_multitouchapp"
    When I execute "@app.MainWindow.pinch_zoom_in(2, 50, :Vertical)"
    Then the Graphicsview of the application should be transformed by the zoom

  Scenario: Execute pinch_zoom_in method so that the pinch motion is horizontal (fingers move left and right)
    Given I launch application "matti_multitouchapp"
    When I execute "@app.MainWindow.pinch_zoom_in(2, 50, :Horizontal)"
    Then the Graphicsview of the application should be transformed by the zoom

