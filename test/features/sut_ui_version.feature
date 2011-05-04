@nodoc @qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#ui_version
  As a test scripter writer
  I want to use ui_version attribute to get ui_version attribute of a sut
  so that I can test the MobyBehaviour::SUT behaviour

  @nodoc
  Scenario: Testing ui_version attribute
    Given I create sut object "sut_qt"
    When I execute "@my_ui_version = @sut.ui_version"
    #Then verify "@my_ui_version.to_i >= 200701"
    Then verify "@my_ui_version.kind_of?( String )"
