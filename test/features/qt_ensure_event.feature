@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Synchronization#ensure_event
  As a test scripter writer
  I want to use ensure_event to make sure target object receives the signal thrown
  so that I can test the MobyBehaviour::QT::Synchronization behaviour

  Scenario: Testing ensure_event with default parameters
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:name => 'oneButton').ensure_event() { @app.Button( :name => 'oneButton' ).tap }" 
    Then exception is not thrown

  Scenario: Testing ensure_event event not sent
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:name => 'oneButton').ensure_event(:retry_timeout => 3, :retry_interval => 0.1) { @app.Button( :name => 'twoButton' ).tap }" 
    Then exception matching "No event received" is thrown

   Scenario: Testing tapping with ensure parameter
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:name => 'oneButton').tap(:ensure_event => 'true')"
    Then exception is not thrown

   Scenario: Testing tapping with ensure parameter set false
    Given I launch application "calculator" as "@app"
    When I execute "@app.Button(:name => 'oneButton').tap(:ensure_event => 'false')"
    Then exception is not thrown
  
