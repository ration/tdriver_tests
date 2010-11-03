@qt_linux @qt_windows @qt_meego @qt_symbian

Feature: MobyBehaviour::QT::Multitouch#pinch_zoom_out
  As a test script writer
  I want to use pinch zoom method to simulate effect of user doing a pinch zoom operation,
  so that I can test the MobyBehaviour::QT::Multitouch behaviour

  Scenario: Execute pinch_zoom_out method so that the pinch motion is vertical (fingers move up and down)
    Given I launch application "matti_multitouchapp"
	And I zoom in with params 2, 50, 180
    And the Graphicsview of the application should be transformed by the zoom
    When I execute "@app.MainWindow.pinch_zoom_out(2, 50, :Vertical)"
    Then the Graphicsview of the application should not be transformed by the zoom

  Scenario: Execute pinch_zoom_out method so that the pinch motion is horizontal (fingers move left and right)
    Given I launch application "matti_multitouchapp"
	And I zoom in with params 2, 50, 0
    And the Graphicsview of the application should be transformed by the zoom
    When I execute "@app.MainWindow.pinch_zoom_out(2, 50, :Horizontal)"
    Then the Graphicsview of the application should not be transformed by the zoom

