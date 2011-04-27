@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#state_object
  As a test scripter writer
  I want to use state method to get the static state object for the sut
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing sut state method 
    Given I have default sut
    When I execute "$sut_state = @sut.state_object"
    Then "$sut_state" is a static state object

  @nodoc
  Scenario: Testing sut state method with deprecated method name
    Given I have default sut
    When I execute "$sut_state=@sut.state"
    Then "$sut_state" is a static state object

