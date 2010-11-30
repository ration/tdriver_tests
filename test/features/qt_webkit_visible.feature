@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Webkit
  As a test scripter writer
  I want to check that webkit visible attribute is working correctly
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: Check element with property display:none or visibility:hidden has visible attribute set to false
    Given I launch application "browser"
		Then I move to page "../html/html_css.html"
		Then I verify that the page is loaded
		Then verify "@app.h1( :name => 'h1' ).attribute('visible')=='true'"
		Then verify "@app.h2( {:name => 'h2',:id => 'display_none'} ).attribute('visible')=='false'"
		Then verify "@app.h3( :name => 'h3' ).attribute('visible')=='false'"
		Then verify "@app.h4( :name => 'h4' ).attribute('visible')=='false'"
		Then verify "@app.h5( :name => 'h5' ).attribute('visible')=='false'"
		Then verify "@app.h6( :name => 'h6' ).attribute('visible')=='false'"
		
		