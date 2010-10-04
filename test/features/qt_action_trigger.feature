@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Action#trigger
  As a test scripter writer
  I want to use trigger method to move mouse cursor to the widget that would activate an action, so that action receives trigger signal,
  so that I can test the MobyBehaviour::QT::Action behaviour

  Scenario: Testing trigger method opening a menu from menubar
    Given I launch application "calculator"
    When I execute "@app.QMenuBar( :name => 'menuBar' ).QAction( :name => 'mainMenuAction' ).trigger"
    Then object named "mainMenu" is visible

  Scenario: Testing trigger method on a tool button in a tool bar
    Given I launch application "calculator"
    And I tap Button named "fourButton"
    Then The calculator display says "4"
    When I execute "@app.QToolBar( :name => 'toolBar' ).QToolButton( :text => 'Clear' ).QAction( :name => 'clearAction' ).trigger"
    Then The calculator display says "0"

  Scenario: Testing trigger method on a menu item under a menubar
    Given I launch application "calculator"
    And I tap Button named "fourButton"
    Then The calculator display says "4"
    Given I trigger "mainMenuAction" from "menuBar"
    Then object named "mainMenu" is visible
    When I execute "@app.QMenu( :name => 'mainMenu' ).QAction( :name => 'clearAction' ).trigger"
    Then The calculator display says "0"

  Scenario: Testing trigger method on an action directly under QToolBar
    Given I launch application "calculator"
    And I tap Button named "fourButton"
    Then The calculator display says "4"
    When I execute "@app.QToolBar( :name => 'toolBar' ).QAction( :name => 'clearAction' ).trigger"
    Then The calculator display says "0"

@nodoc
  Scenario: Testing trigger method opening a menu from menubar with refresh
    Given I launch application "calculator"
    When I execute "@app.QMenuBar( :name => 'menuBar' ).QAction( :name => 'mainMenuAction' ).trigger(1)"
    Then object named "mainMenu" is visible

@nodoc
  Scenario: Testing trigger method on a tool button in a tool bar with refresh
    Given I launch application "calculator"
    And I tap Button named "fourButton"
    Then The calculator display says "4"
    When I execute "@app.QToolBar( :name => 'toolBar' ).QToolButton( :text => 'Clear' ).QAction( :name => 'clearAction' ).trigger(1)"
    Then The calculator display says "0"

@nodoc
  Scenario: Testing trigger method on a menu item under a menubar with refresh
    Given I launch application "calculator"
    And I tap Button named "fourButton"
    Then The calculator display says "4"
    Given I trigger "mainMenuAction" from "menuBar"
    Then object named "mainMenu" is visible
    When I execute "@app.QMenu( :name => 'mainMenu' ).QAction( :name => 'clearAction' ).trigger(1)"
    Then The calculator display says "0"

@nodoc
  Scenario: Testing trigger method on an action directly under QToolBar with refresh
    Given I launch application "calculator"
    And I tap Button named "fourButton"
    Then The calculator display says "4"
    When I execute "@app.QToolBar( :name => 'toolBar' ).QAction( :name => 'clearAction' ).trigger(1)"
    Then The calculator display says "0"
