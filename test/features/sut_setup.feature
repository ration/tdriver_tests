@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#setup
  As a test scripter writer
  I want to use setup method to execute my custom setup for the sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing setup method
    Given I have default sut
    And I set the value "sut_setup.rb" to "sut_setup" sut parameter
    When I execute "@sut.setup"
    Then exception is not thrown


