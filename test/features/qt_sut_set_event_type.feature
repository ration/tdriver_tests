#@qt_linux @qt_windows @qt_symbian @qt_meego

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
    
  @nodoc	
  Scenario: Test that only mouse events are generated  when event type is set to :Mouse
    Given I launch application "matti_multitouchapp" as "@app"
    And I press the next 2 times
    When I execute "@__sut.set_event_type(:Mouse)"
    And I enable listen to events for object "@app.Square(:name =>'topLeft')" in matti_multitouchapp
    Then I tap object "@app.Square(:name =>'topLeft')" in matti_multitouchapp
    And I test code "$event_list=@app.Square(:name =>'topLeft').get_events"
    Then the results of "@app.Square(:name =>'topLeft')" should not contain "TouchBegin,TouchEnd"
    
  @nodoc
  Scenario: Test that only mouse events are generated  when event type is set to :Touch
    Given I launch application "matti_multitouchapp" as "@app"
    And I press the next 2 times
    When I execute "@__sut.set_event_type(:Touch)"
    And I enable listen to events for object "@app.Square(:name =>'topLeft')" in matti_multitouchapp
    Then I tap object "@app.Square(:name =>'topLeft')" in matti_multitouchapp
    And I test code "$event_list=@app.Square(:name =>'topLeft').get_events"
    Then the results of "@app.Square(:name =>'topLeft')" should not contain "GrabMouse,UnGrabMouse"

