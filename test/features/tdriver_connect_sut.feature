@qt_linux @qt_windows @qt_symbian @qt_meego @dev

Feature: TDriver::connect_sut
  As a test script writer
  I want to connect to a sut
  so that I can test an application.

  Scenario: Connect to sut_qt
    When I execute "@connected_sut = TDriver.connect_sut(:Id => 'sut_qt')"
    Then id of connected sut is "sut_qt"

@nodoc
  Scenario: Connect to an invalid sut
    When I execute "TDriver.connect_sut(:Id => 'sut_invalid_and_not_found')"
    Then exception is thrown
  