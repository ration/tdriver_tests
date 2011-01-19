@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::Find#find
  As a test scripter writer
  I want to use find method to find test objects in target application based on any attributes,
  so that I can test the MobyBehaviour::Find behaviour

@nodoc
  Scenario: Testing find method with no arguments
    Given I have default sut
    And I launch application "testapp"
    When I test code "@testobj = @sut.find"
    Then exception matching "Attributes hash must not be empty" is thrown

#@nodoc
  #Scenario: Testing find method on non-existing object
  #  Given I have default sut
  #  And I launch application "testapp"
  #  When I test code "@testobj = @sut.find( :name => 'Node0' )"
  #  Then exception matching "Cannot find object with rule" is thrown

@nodoc
  Scenario: Testing find method with one ambiguous argument
    Given I have default sut
    And I launch application "testapp"
	And I test code "@sut.application.NodeView"
    When I test code "@testobj = @sut.find( :type => 'Control', :__timeout => 0 )"
    Then exception matching "Multiple test objects found with rule" is thrown

  Scenario: Testing find method with one unambiguous attribute argument
    Given I have default sut
    And I launch application "testapp"
	And I test code "@sut.application.NodeView"
    When I execute "@testobj = @sut.find( :name => 'Node1' )"
    Then a test object is found by find

  Scenario: Testing find method with one unambiguous special argument
    Given I have default sut
    And I launch application "testapp"
	And I test code "@sut.application.NodeView"
    When I execute "@testobj = @sut.find( :type => 'Node' )"
    Then a test object is found by find

  Scenario: Testing find method with two unambiguous arguments
    Given I have default sut
    And I launch application "testapp"
	And I test code "@sut.application.NodeView"
    When I execute "@testobj = @sut.find( :type => 'Control', :name => 'AddNode' )"
    Then a test object is found by find
