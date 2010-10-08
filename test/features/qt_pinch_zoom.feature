@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::QT::Multitouch#pinch_zoom
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

  Scenario: Execute pinch_zoom method with custom parameters (zooming in)
    Given I launch application "matti_multitouchapp"
    When I execute "@app.MainWindow.pinch_zoom({:type => :in, :speed => 2, :distance_1 => 50, :distance_2 => 50, :direction => 70, :differential => 10})"
    Then the Graphicsview of the application should be transformed by the zoom

  Scenario: Execute pinch_zoom method with custom parameters (zooming out) 
    Given I launch application "matti_multitouchapp"
	And I zoom in with params 2, 50, 180
    And the Graphicsview of the application should be transformed by the zoom
    When I execute "@app.MainWindow.pinch_zoom({:type => :out, :speed => 2, :distance_1 => 50, :distance_2 => 50, :direction => 70, :differential => 10})"
    Then the Graphicsview of the application should not be transformed by the zoom

  Scenario: Execute pinch_zoom method with custom parameters (zooming in, one finger stationary)
    Given I launch application "matti_multitouchapp"
    When I execute "@app.MainWindow.pinch_zoom({:type => :in, :speed => 2, :distance_1 => 100, :distance_2 => 0, :direction => 0, :differential => 10})"
    Then the Graphicsview of the application should be transformed by the zoom

  Scenario: Execute pinch_zoom method with custom parameters (zooming out, one finger stationary)
    Given I launch application "matti_multitouchapp"
	And I zoom in with params 2, 50, 180
    And the Graphicsview of the application should be transformed by the zoom
    When I execute "@app.MainWindow.pinch_zoom({:type => :out, :speed => 2, :distance_1 => 0, :distance_2 => 1000, :direction => 0, :differential => 10})"
    Then the Graphicsview of the application should not be transformed by the zoom
