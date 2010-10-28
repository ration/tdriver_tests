@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#system_information
  As a test scripter writer RESERVED
  I want to use system_information method to query system information
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Retrieve all system information
    Given I have default sut
    When I execute "@info = @sut.system_information"
    Then nothing to verify
