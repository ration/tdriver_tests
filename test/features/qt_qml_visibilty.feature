@qt_linux @qt_windows @qt_symbian @qt_meego @nodoc

Feature: QML Object with opacity 0 should is not visible
  As a test scripter writer
  I want to use change_orientation method to change the orientation of the application


Scenario: Change orientation using the change_orientation method
  Given I launch application "hybrid_app" as "@app"  
  And verify "@app.QDeclarativeRectangle(:name => 'Visible').attribute('visibleOnScreen') == 'false'"
  When I test code "@app.QDeclarativeRectangle(:name => 'Click').tap"
  And verify "@app.QDeclarativeRectangle(:name => 'Visible').attribute('visibleOnScreen') == 'true'"
  Then I test code "@app.QDeclarativeRectangle(:name => 'Click').tap"
  And verify "@app.QDeclarativeRectangle(:name => 'Visible').attribute('visibleOnScreen') == 'false'"
