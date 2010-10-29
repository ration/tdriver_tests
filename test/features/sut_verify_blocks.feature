Feature: MobyBehaviour::SUT#verify_blocks
  As a test scripter writer
  I want to use verify_blocks attribute to get the current blocks in the sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing verify_blocks attribute (Rename this to be more descriptive)
    Given I have default sut
    And I add a verify_always block on the sut
    When I execute "@sut.verify_blocks"
    Then the code "!@sut.verify_blocks.empty?" returns true

