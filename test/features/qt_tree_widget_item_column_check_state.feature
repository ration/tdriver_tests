@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::QT::TreeWidgetItemColumn#check_state
  As a test scripter writer
  I want to use check_state method to change checkState value of QTreeWidgetItem
  so that I can test the MobyBehaviour::QT::TreeWidgetItemColumn behaviour

  Scenario: Changing unchecked TreeWidgetItem state to partially checked
    Given I launch application "treewidgetapp" as "@app"
    When I execute "@app.TreeWidgetItemColumn( :text => 'Qt::Unchecked' ).check_state( 1 )"
    Then verify "@app.TreeWidgetItemColumn( :text => 'Qt::Unchecked' ).attribute('checkState') == '1'"

  @nodoc
  Scenario: Changing unchecked TreeWidgetItem state to checked
    Given I launch application "treewidgetapp" as "@app"
    When I execute "@app.TreeWidgetItemColumn( :text => 'Qt::Unchecked' ).check_state( 2 )"
    Then verify "@app.TreeWidgetItemColumn( :text => 'Qt::Unchecked' ).attribute('checkState') == '2'"

  @nodoc
  Scenario: Changing partially checked TreeWidgetItem state to unchecked
    Given I launch application "treewidgetapp" as "@app"
    When I execute "@app.TreeWidgetItemColumn( :text => 'Qt::PartiallyChecked' ).check_state( 0 )"
    Then verify "@app.TreeWidgetItemColumn( :text => 'Qt::PartiallyChecked' ).attribute('checkState') == '0'"
 
  Scenario: Changing partially checked TreeWidgetItem state to checked
    Given I launch application "treewidgetapp" as "@app"
    When I execute "@app.TreeWidgetItemColumn( :text => 'Qt::PartiallyChecked' ).check_state( 2 )"
    Then verify "@app.TreeWidgetItemColumn( :text => 'Qt::PartiallyChecked' ).attribute('checkState') == '2'"

  Scenario: Changing checked TreeWidgetItem state to unchecked
    Given I launch application "treewidgetapp" as "@app"
    When I execute "@app.TreeWidgetItemColumn( :text => 'Qt::Checked' ).check_state( 0 )"
    Then verify "@app.TreeWidgetItemColumn( :text => 'Qt::Checked' ).attribute('checkState') == '0'"

  @nodoc
  Scenario: Changing checked TreeWidgetItem state to partially checked
    Given I launch application "treewidgetapp" as "@app"
    When I execute "@app.TreeWidgetItemColumn( :text => 'Qt::Checked' ).check_state( 1 )"
    Then verify "@app.TreeWidgetItemColumn( :text => 'Qt::Checked' ).attribute('checkState') == '1'"











