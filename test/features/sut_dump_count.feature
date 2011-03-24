@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#dump_count=
  As a test scripter writer
  I want to use dump_count attribute to get number of UI dump requests in sut
  so that I can test the MobyBehaviour::SUT behaviour
  
  Scenario: Testing dump_count attribute after refresh
    Given I have default sut
    When I execute "@sut.refresh"
    Then verify "@sut.dump_count>1"

  Scenario: Testing dump_count= attribute 
    Given I have default sut
    When I execute "@sut.dump_count=2"
    Then verify "@sut.dump_count==2"

