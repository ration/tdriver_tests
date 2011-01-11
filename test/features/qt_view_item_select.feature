@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::ViewItem#select
  As a test scripter writer
  I want to use select method to select item in QTreeView in treewidgetapp
  so that I can test the MobyBehaviour::QT::ViewItem behaviour

  Scenario: Select given QTreeWidgetItem object
    Given I launch application "treewidgetapp" as "@app"
    When I execute "@app.QTreeWidgetItem(:__index=>0 ).select"
    Then verify "@app.QTreeWidgetItem(:__index=>0 ).attribute('selected').to_s == 'true'"
    
