@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#system_total_mem
  As a test scripter writer
  I want to use system_total_mem method to query total system memory
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Query system total memory
    Given I have default sut
    When I execute "@sut_system_total_mem = @sut.system_total_mem"
    Then verify "@sut_system_total_mem > 0"

