@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObjectSynchronization#wait_child
  As a test scripter writer
  I want to use wait_child method to wait until a test object has a child matching given attributes in calculator
  so that I can test the MobyBehaviour::TestObjectSynchronization behaviour

  Scenario: Testing wait_child method with argument 'attributes'  that the child object must have 
    Given I launch application "calculator" as "@app"
    When I execute "@app.QToolBar( :name => 'toolBar' ).wait_child({:type=>'QToolButton',:text => 'Clear'} )"
    Then exception is not thrown

  Scenario: Testing wait_child method with optional 'timeout_secs' argument, specifying timeout before exception is thrown, if child object cannot be found
    Given I launch application "calculator" as "@app"
    When I execute "@app.QToolBar( :name => 'toolBar' ).wait_child({:type=>'QToolButton',:text => 'Clear'} ,30)"
    Then exception is not thrown

  Scenario: Testing wait_child method with optional 'retry_interval' argument specifying time to wait before retrying to find test object 
    Given I launch application "calculator" as "@app"
    When I execute "@app.QToolBar( :name => 'toolBar' ).wait_child({:type=>'QToolButton',:text => 'Clear'},30,1)"
    Then exception is not thrown

