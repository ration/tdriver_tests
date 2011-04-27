@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBase::StateObject
  As a test scripter writer
  I want to use child and children methods to access data in state object
  so that I can test the MobyBase::StateObject module

  @nodoc
  Scenario: Perform child method to StateObject
    Then I set create xml state with 3 objects and store it in "@xml_data" 
    When I execute "TDriver.state_object( :source_data => @xml_data ).child( :id=>'2' )"
    Then verify "@__ret_val.name == 'object_2'"

  @nodoc
  Scenario: Perform child method to StateObject
    Then I set create xml state with 10 objects and store it in "@xml_data" 
    When I execute "TDriver.state_object( :source_data => @xml_data ).children( :type=>'obj' )"
    Then verify "@__ret_val.count == 10"

