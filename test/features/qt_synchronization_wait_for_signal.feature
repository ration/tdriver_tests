@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Synchronization#wait_for_signal
  As a test scripter writer
  I want to use wait_for_signal method to synchronizes script execution to a signal in calculator
  so that I can test the MobyBehaviour::QT::Synchronization behaviour

  Scenario: Testing wait_for_signal method with required signal timeout and signal name
    Given I launch application "calculator" as "@app"
    And I listen for signal clicked() from button "oneButton" using fixture
    And I tap Button named "oneButton"
    When I execute "@app.Button( :name => 'oneButton' ).wait_for_signal(3,'clicked()')"



