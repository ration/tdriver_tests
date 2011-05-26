Feature: MobyBehaviour::AgentCommands#version
  As a test scripter writer
  I want to use version method to query agent version number
  so that I can test the MobyBehaviour::AgentCommands behaviour

@qt_linux @qt_windows @qt_symbian @qt_meego
  Scenario: Query agent version number
    Given I have default sut
    When I execute "@sut.agent.version"
    And exception is not thrown
    And I test code "@__ret_val.kind_of?( String ) && @__ret_val.empty? == false"

