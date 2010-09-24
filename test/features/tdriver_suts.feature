@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: TDriver::suts should list defined suts
  As a test script writer
  I want to list available suts
  so that I can verify my TDriver configuration

  Scenario: Query list of suts
    When I execute "@tdriver_suts_list = TDriver.suts"
    Then suts returns a non-empty list
