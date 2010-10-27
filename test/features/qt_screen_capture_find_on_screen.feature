Feature: MobyBehaviour::QT::ScreenCapture#find_on_screen
  As a test scripter writer
  I want to use find_on_screen method to search the SUT screen for the given image and get the top left coordinates
  so that I can test the MobyBehaviour::QT::ScreenCapture behaviour

@qt_windows
  Scenario: Find image from sut screen
    Given I launch application "calculator"
    And I test code "@app.Button( :name => 'clearAllButton' ).capture_screen('PNG','C:/temp/clear_all_button_image.PNG',true)"
    And exception is not thrown
    When I execute "@clear_all_button_coordinates=@app.find_on_screen('C:/temp/clear_all_button_image.PNG')"
    And exception is not thrown
    Then the coordinates of clear all button are found
    And I delete file "C:/temp/clear_all_button_image.PNG"

@qt_windows
  Scenario: Find image from sut screen using tolerance 20
    Given I launch application "calculator"
    And I test code "@app.Button( :name => 'clearAllButton' ).capture_screen('PNG','C:/temp/clear_all_button_image.PNG',true)"
    And exception is not thrown
    When I execute "@clear_all_button_coordinates=@app.find_on_screen('C:/temp/clear_all_button_image.PNG',20)"
    And exception is not thrown
    Then the coordinates of clear all button are found
    And I delete file "C:/temp/clear_all_button_image.PNG"

@qt_linux
  Scenario: Find image from sut screen
    Given I launch application "calculator"
    And I test code "@app.Button( :name => 'clearAllButton' ).capture_screen('PNG','/tmp/clear_all_button_image.PNG',true)"
    And exception is not thrown
    When I execute "@clear_all_button_coordinates=@app.find_on_screen('/tmp/clear_all_button_image.PNG')"
    And exception is not thrown
    Then the coordinates of clear all button are found
    And I delete file "/tmp/clear_all_button_image.PNG"

@qt_linux
  Scenario: Find image from sut screen using tolerance 20
    Given I launch application "calculator"
    And I test code "@app.Button( :name => 'clearAllButton' ).capture_screen('PNG','/tmp/clear_all_button_image.PNG',true)"
    And exception is not thrown
    When I execute "@clear_all_button_coordinates=@app.find_on_screen('/tmp/clear_all_button_image.PNG',20)"
    And exception is not thrown
    Then the coordinates of clear all button are found
    And I delete file "/tmp/clear_all_button_image.PNG"