Feature: MobyBehaviour::QT::ScreenCapture#screen_contains?
  As a test scripter writer
  I want to use screen_contains? method to verify if the given image is found from the device screen
  so that I can test the MobyBehaviour::QT::ScreenCapture behaviour

@qt_windows
  Scenario: Check that image is found from screen
    Given I launch application "calculator"
    And I test code "@app.Button( :name => 'clearAllButton' ).capture_screen('PNG','C:/temp/clear_all_button_image.PNG',true)"
    And exception is not thrown
    When I execute "@clear_all_button_image_found = @app.screen_contains?('C:/temp/clear_all_button_image.PNG')"
    And exception is not thrown
    Then clear all button image is found
    And I can delete file "C:/temp/clear_all_button_image.PNG"

@qt_windows
  Scenario: Check that image is found from screen using tolerance 20
    Given I launch application "calculator"
    And I test code "@app.Button( :name => 'clearAllButton' ).capture_screen('PNG','C:/temp/clear_all_button_image.PNG',true)"
    And exception is not thrown
    When I execute "@clear_all_button_image_found = @app.screen_contains?('C:/temp/clear_all_button_image.PNG',20)"
    And exception is not thrown
    Then clear all button image is found
    And I can delete file "C:/temp/clear_all_button_image.PNG"

@qt_linux @qt_meego
  Scenario: Check that image is found from screen
    Given I launch application "calculator"
    And I test code "@app.Button( :name => 'clearAllButton' ).capture_screen('PNG','/tmp/clear_all_button_image.PNG',true)"
    And exception is not thrown
    When I execute "@clear_all_button_image_found = @app.screen_contains?('/tmp/clear_all_button_image.PNG')"
    And exception is not thrown
    Then clear all button image is found
    And I can delete file "/tmp/clear_all_button_image.PNG"

@qt_linux @qt_meego
  Scenario: Check that image is found from screen using tolerance 20
    Given I launch application "calculator"
    And I test code "@app.Button( :name => 'clearAllButton' ).capture_screen('PNG','/tmp/clear_all_button_image.PNG',true)"
    And exception is not thrown
    When I execute "@clear_all_button_image_found = @app.screen_contains?('/tmp/clear_all_button_image.PNG',20)"
    And exception is not thrown
    Then clear all button image is found
    And I can delete file "/tmp/clear_all_button_image.PNG"
