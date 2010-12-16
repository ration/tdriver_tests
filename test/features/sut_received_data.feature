@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#received_data
  As a test scripter writer
  I want to use received_data method to get the amount of data received from sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Retrieve received data from sut
    Given I have default sut
    And I launch application "testapp" as "@app"
    When I execute "@received_data=@sut.received_data()"
    Then the amount of received data is retrieved

