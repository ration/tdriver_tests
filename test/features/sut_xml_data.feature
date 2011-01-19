@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#xml_data
  As a test scripter writer
  I want to use xml_data attribute to force use of user defined ui state  
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing xml_data= method
    Given I have default sut
    And I test code "$xml=@sut.xml_data"
    When I execute "@sut.xml_data=$xml"
    Then exception is not thrown


