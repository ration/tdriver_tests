@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#set_event_type
  As a test scripter writer
  I want to set the event type for the target with the set_event_type method
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Using set_event_type to set the event type to mouse
    Given I have default sut
    When I execute "@sut.set_event_type(:Mouse)"
    Then exception is not thrown
    
  Scenario: Using set_event_type to set the event type to touch
    Given I have default sut
    When I execute "@sut.set_event_type(:Touch)"
    Then exception is not thrown

  Scenario: Using set_event_type to set the event type to both (mouse and touch)
    Given I have default sut
    When I execute "@sut.set_event_type(:Both)"
    Then exception is not thrown