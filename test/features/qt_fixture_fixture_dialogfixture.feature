@qt_windows
Feature: MobyBehaviour::QT::Fixture#fixture
  As a test scripter writer
  I want to use fixture method to tap and send text to native dialogs
  so that I can test the MobyBehaviour::QT::Fixture behaviour and the dialogfixture

  Scenario: Tap a native dialog button
    Given I have default sut
    And I launch application "nativedialog_testapp"
    And I tap the open button in the tool bar
    And I sleep "1" second
    When I execute "@sut.fixture('dialog', 'tap_control', { :dialog_name => 'Open', :name_pattern => 'Cancel', :class_pattern => 'Button' } )"
    Then exception is not thrown

  Scenario: Send text to a native dialog button
    Given I have default sut
    And I launch application "nativedialog_testapp"
    And I tap the open button in the tool bar
    And I sleep "1" second
    When I execute "@sut.fixture('dialog', 'send_text', { :dialog_name => 'Open', :class_pattern => 'ComboBoxEx32', :text => '\qttas\bin\runner.bat' } )"
    Then I sleep "3" second
    And I tap the native dialog "&Open" button
    And exception is not thrown
  