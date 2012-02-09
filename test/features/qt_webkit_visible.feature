@qt_windows @qt_linux @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Webkit
  As a test scripter writer
  I want to check that webkit visible attribute is working correctly
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: Check element with property display:none or visibility:hidden has visible attribute set to false
    Given I launch browser
		Then I move to page "../html/html_css.html"
		Then I verify that the page is loaded
		Then verify "@app.h1( :name => 'h1' ).attribute('visible')=='true'"
		Then verify "@app.h2( :name => 'h2' ).attribute('visible')=='true'"
		Then verify "@app.h3( :name => 'h3' ).attribute('visible')=='false'"		
		Then verify "@app.h5( :name => 'h5' ).attribute('visible')=='false'"		
		
	Scenario: Check frames with style property has visible attribute set to correctly
    Given I launch browser
		Then I move to page "../html/html_nested_frames.html"
		Then I verify that the page is loaded
		Then verify "@app.QWebFrame( :name => '<!--framePath //<!--frame0-->-->' ).attribute('visibility')=='true'"
		Then verify "@app.QWebFrame( :name => '<!--framePath //<!--frame1-->-->' ).attribute('visibility')=='true'"
		Then verify "@app.QWebFrame( :name => '<!--framePath //<!--frame1-->/<!--frame0-->-->' ).attribute('visibility')=='true'"
		Then verify "@app.QWebFrame( :name => '<!--framePath //<!--frame1-->/<!--frame1-->-->' ).attribute('visibility')=='false'"
		Then verify "@app.QWebFrame( :name => '<!--framePath //<!--frame1-->/<!--frame1-->-->' ).attribute('style')=='visibility:hidden;'"
		
		
