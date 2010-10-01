@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Action#hover
  As a test scripter writer
  I want to use hover method to move mouse cursor to the widget that would activate an action, so that action receives hover signal,
  so that I can test the MobyBehaviour::QT::Action behaviour

  Scenario: Testing hover method on an independent QToolButton
    Given I launch application "calculator"
    And I store position of QToolButton "evadingButton"
    When I execute "@app.QToolButton( :name => 'evadingButton' ).QAction( :name => 'evadeAction' ).hover"
    Then position of QToolButton "evadingButton" has changed or not
