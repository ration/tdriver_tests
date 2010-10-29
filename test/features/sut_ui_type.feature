@nodoc @qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#ui_type
  As a test scripter writer
  I want to use ui_type attribute to get ui_type attribute of a sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing ui_type attribute
    Given I create sut object "sut_qt"
    When I execute "@my_ui_type = @sut.ui_type"
    Then verify "@my_ui_type == 'QT'"
