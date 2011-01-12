@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#clear_verify_blocks
  As a test scripter writer
  I want to use clear_verify_blocks method to clear all verify_always blocs in the sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing clear_verify_blocks method
    Given I have default sut
    And I add a verify_always block on the sut
    When I execute "@sut.clear_verify_blocks"
    Then the code "@sut.verify_blocks.empty?" returns true

