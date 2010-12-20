@qt_symbian @nodoc

Feature: Test symbian sut hybrid support
  As a test script writer
  I want to test the an application that has both qt and avkon components
  so that I can test applications with qt and avkon components

  Scenario: Verify that both qt and avkon components are in the ui state
    Given I launch application "hybrid_app" as "@app"
	Then I get qt and avkon components


  Scenario: Tap qt and avkon components from the same application
    Given I launch application "hybrid_app" as "@app"
    When I tap the Click rectangle
	Then the buttonText will be Released
	Then I tap Softkey Exit
    Then application "hybrid_app" is not running



