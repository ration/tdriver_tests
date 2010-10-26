@qt_linux @qt_windows @qt_symbian @qt_meego @dev

Feature: MobyBehaviour::FlashBehaviour#flash
  As a test scripter writer
  I want to use flash method to control device software update
  so that I can test the MobyBehaviour::FlashBehaviour behaviour

  Scenario: When I set the following TDriver parameters for sut I can use the flash method
    Given I have default sut
    When I set he mandatory flash parameters for sut
    Then I execute "@sut.flash"
    And exception is not thrown

