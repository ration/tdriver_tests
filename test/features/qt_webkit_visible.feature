@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Webkit#*****
  As a test scripter writer
  I want to check that webkit visible attribute is working correctly
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: Check element with property display:none has visible attribute set to false
    Given I launch application "browser"
		Then I move to page "../html/html_css.html"
		Then I verify that the page is loaded
		Then I verify that "h1" is having "visible" with value "true"
		Then I verify that "h2" is having "visible" with value "false"
		Then I verify that "h3" is having "visible" with value "false"
		Then I verify that "h4" is having "visible" with value "false"
