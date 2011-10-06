Feature: MobyBehaviour::QT::ScreenCapture#capture_screen
  As a test scripter writer
  I want to use capture_screen method to to take snapshot of SUTs current display view
  so that I can test the MobyBehaviour::QT::ScreenCapture behaviour

@qt_windows
  Scenario: Capture screen from the test application
    Given I launch application "calculator"
    When I execute "@screen_capture_data = @app.capture_screen"
    And exception is not thrown
    Then I can use the image data and write it to a file "C:/temp/screen.png"
    And I can delete file "C:/temp/screen.png"

@qt_windows
  Scenario: Capture screen from the test application with argument 'format'
    Given I launch application "calculator"
    When I execute "@screen_capture_data = @app.capture_screen('PNG')"
    And exception is not thrown
    Then I can use the image data and write it to a file "C:/temp/screen.png"
    And I can delete file "C:/temp/screen.png"

@qt_windows
  Scenario: Capture screen from the test application with argument 'file_name'
    Given I launch application "calculator"
    When I execute "@app.capture_screen('PNG', 'C:/temp/screen.png')"
    And exception is not thrown
    Then I can delete file "C:/temp/screen.png"

@nodoc @qt_windows
  Scenario: Capture screen from the test application with argument 'draw' set to true
    Given I launch application "calculator"
    When I execute "@app.capture_screen('PNG', 'C:/temp/screen.png', true)"
    And exception is not thrown
    Then I can delete file "C:/temp/screen.png"

@qt_windows
  Scenario: Capture screen from the test application with argument 'draw' set to false
    Given I launch application "calculator"
    When I execute "@app.capture_screen('PNG', 'C:/temp/screen.png', false)"
    And exception is not thrown
    Then I can delete file "C:/temp/screen.png"

@qt_linux @qt_meego
  Scenario: Capture screen from the test application
    Given I launch application "calculator"
    When I execute "@screen_capture_data = @app.capture_screen"
    And exception is not thrown
    Then I can use the image data and write it to a file "/tmp/screen.png"
    And I can delete file "/tmp/screen.png"

@qt_linux @qt_meego
  Scenario: Capture screen from the test application with argument 'format'
    Given I launch application "calculator"
    When I execute "@screen_capture_data = @app.capture_screen('PNG')"
    And exception is not thrown
    Then I can use the image data and write it to a file "/tmp/screen.png"
    And I can delete file "/tmp/screen.png"

@qt_linux @qt_meego
  Scenario: Capture screen from the test application with argument 'file_name'
    Given I launch application "calculator"
    When I execute "@app.capture_screen('PNG', '/tmp/screen.png')"
    And exception is not thrown
    Then I can delete file "/tmp/screen.png"

@qt_linux @qt_meego
  Scenario: Capture screen from the test application with argument 'draw' set to true
    Given I launch application "calculator"
    When I execute "@app.capture_screen('PNG', '/tmp/screen.png', true)"
    And exception is not thrown
    Then I can delete file "/tmp/screen.png"

@nodoc @qt_linux @qt_meego
  Scenario: Capture screen from the test application with argument 'draw' set to false
    Given I launch application "calculator"
    When I execute "@app.capture_screen('PNG', '/tmp/screen.png', false)"
    And exception is not thrown
    Then I can delete file "/tmp/screen.png"


