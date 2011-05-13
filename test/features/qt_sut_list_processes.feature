@qt_windows @qt_symbian 

Feature: MobyBehaviour::QT::SUT#list_processes
  As a test scripter writer
  I want to use list_processes method to list running processes on the target
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: List running processes on target
    Given I have default sut
    When I execute "@state_object = @sut.state_object(@sut.list_processes)"
    Then verify "nil != @state_object.process(:name => 'qttasserver').attribute('memUsage')"
