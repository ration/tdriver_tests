@qt_symbian

Feature: MobyBehaviour::QT::SUT#cpu_load_stop
  As a test scripter writer
  I want to use cpu_load_stop method to stop generating CPU load
  so that I can test the MobyBehaviour::QT::SUT behaviour
  
  Scenario: Testing cpu_load_stop method for sut
	Given I have default sut
	And I test code "@sut.cpu_load_start(15)"
    When I execute "@sut.cpu_load_stop()"
    Then exception is not thrown

