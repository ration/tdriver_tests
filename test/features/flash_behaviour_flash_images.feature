@qt_linux @qt_windows @qt_symbian @qt_meego @dev

Feature: MobyBehaviour::FlaxiBehaviour#flash_images
  As a test scripter writer
  I want to use flash_images method to control device software update
  so that I can test the MobyBehaviour::FlashBehaviour behaviour

  Scenario: When I set the following TDriver parameters for sut I can use the flash_images method without arguments
    Given I have default sut
    When I set he mandatory flash parameters for sut
    Then I execute "@sut.flash_images"
    And exception is not thrown

  Scenario: When I set the following TDriver parameters for sut I can use the flash_images method with arguments
    Given I have default sut
    When I set he mandatory flash parameters for sut
    Then I execute "@sut.flash_images('/img/sw_image.img')"
    And exception is not thrown

