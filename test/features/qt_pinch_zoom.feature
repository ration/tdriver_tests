@qt_linux @qt_windows @qt_meego @qt_symbian

Feature: MobyBehaviour::QT::Multitouch#pinch_zoom
  As a test script writer
  I want to use pinch zoom method to simulate effect of user doing a pinch zoom operation,
  so that I can test the MobyBehaviour::QT::Multitouch behaviour

  Scenario: Execute pinch_zoom method with custom parameters (zooming in)
    Given I launch application "matti_multitouchapp"
    When I execute "@app.MainWindow.pinch_zoom( :type => :in, :speed => 2, :distance_1 => 50, :distance_2 => 50, :direction => 70, :differential => 10 )"
    Then the Graphicsview of the application should be transformed by the zoom

  Scenario: Execute pinch_zoom method with custom parameters (zooming out) 
    Given I launch application "matti_multitouchapp"
	And I zoom in with params 2, 50, 180
    And the Graphicsview of the application should be transformed by the zoom
    When I execute "@app.MainWindow.pinch_zoom( :type => :out, :speed => 2, :distance_1 => 50, :distance_2 => 50, :direction => 70, :differential => 10 )"
    Then the Graphicsview of the application should not be transformed by the zoom

  Scenario: Execute pinch_zoom method with custom parameters (zooming in, one finger stationary)
    Given I launch application "matti_multitouchapp"
    When I execute "@app.MainWindow.pinch_zoom( :type => :in, :speed => 2, :distance_1 => 100, :distance_2 => 0, :direction => 0, :differential => 10 )"
    Then the Graphicsview of the application should be transformed by the zoom

  Scenario: Execute pinch_zoom method with custom parameters (zooming out, one finger stationary)
    Given I launch application "matti_multitouchapp"
	And I zoom in with params 2, 50, 180
    And the Graphicsview of the application should be transformed by the zoom
    When I execute "@app.MainWindow.pinch_zoom( :type => :out, :speed => 2, :distance_1 => 0, :distance_2 => 1000, :direction => 0, :differential => 10 )"
    Then the Graphicsview of the application should not be transformed by the zoom
