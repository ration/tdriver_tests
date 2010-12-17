@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#sent_data
  As a test scripter writer
  I want to use sent_data method to get the amount of data sent to sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Retrieve sent data from sut
    Given I have default sut
    And I launch application "testapp" as "@app"
    When I execute "@sent_data=@sut.sent_data()"
    Then the amount of sent data is retrieved

