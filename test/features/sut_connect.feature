@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#connect
  As a test scripter writer
  I want to use connect method to connect to SUT
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Connect to sut_qt using symbol argument
    When I execute "@sut = TDriver.connect_sut( :sut_qt )"
    Then sut id is "sut_qt"

@nodoc
  Scenario: Connect to sut_qt using hash argument
    When I execute "@sut = TDriver.connect_sut( :Id => 'sut_qt' )"
    Then sut id is "sut_qt"
