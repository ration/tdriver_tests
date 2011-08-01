@qt_linux @qt_windows @qt_meego @qt_symbian @nodoc

Feature: Ensure visibility feature
  As a test script writer
  I want to ensure that the item i want to tap is visible
  so that I can test skip pointles dragging

  Scenario: Ensure visibility for qml item inside a flickable area
    Given I launch application "hybrid_app"
    When I drag the 5 qml item for distance of 500
    And qml item 0 is not visible on the screen
    Then I set ensure_qml_visible parameter to true               
    And I tap qml item 0
    And qml item 0 is visible on the screen
    And qml item 0 is focused
    
