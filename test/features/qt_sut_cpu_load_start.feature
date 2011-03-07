@qt_symbian

Feature: MobyBehaviour::QT::SUT#cpu_load_start
  As a test scripter writer
  I want to use cpu_load_start method to start generating CPU load
  so that I can test the MobyBehaviour::QT::SUT behaviour
  
  Scenario: Testing cpu_load_start method for sut
	Given I have default sut
    When I execute "@sut.cpu_load_start(15)"
    Then exception is not thrown
	And I test code "@sut.cpu_load_stop()"
    
