@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::QT::SUT#agent_mem_usage
  As a test script writer
  I want to use agent_mem_usage method to verify agent memory usage,
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Query mem usage of TDriver agent should return positive integer
    Given I have default sut
    When I execute "@sut_agent_mem_usage = @sut.agent_mem_usage"
    Then mem usage result is a positive integer
