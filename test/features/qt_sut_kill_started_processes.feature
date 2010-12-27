@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#kill_started_processes
  As a test scripter writer
  I want to use kill_started_processes method to kill the processes I started
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing kill_started_processes method
    Given I have default sut
    And I launch application "calculator" as "@calcApp"
    And  I launch application "testapp" as "@testApp"
    When I execute "@sut.kill_started_processes"
    Then application "calculator" is not running
    And application "testapp" is not running

