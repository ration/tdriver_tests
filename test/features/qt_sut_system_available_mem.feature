@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#system_available_mem
  As a test scripter writer
  I want to use system_available_mem method to query available memory of the system
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Query available memory of the system
    Given I have default sut
    When I execute "@sut_system_available_mem = @sut.system_available_mem"
    Then verify "@sut_system_available_mem > 0"
