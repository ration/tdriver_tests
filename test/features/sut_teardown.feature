@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#teardown
  As a test scripter writer
  I want to use teardown method to execute my custom teardown for the sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing teardown method
    Given I have default sut
    And I set the value "sut_teardown.rb" to "sut_teardown" sut parameter
    When I execute "@sut.teardown"
    Then exception is not thrown


