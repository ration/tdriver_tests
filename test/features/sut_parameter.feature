Feature: MobyBehaviour::SUT#parameter
  As a test scripter writer
  I want to use parameter method to access sut specific parameters
  so that I can test the MobyBehaviour::SUT behaviour

@pass
  Scenario: Testing parameter method with no arguments
    Given I have default sut
    When I execute "$parameter_hash=@sut.parameter"
    Then I get a Hash containing all sut parameters

@pass
  Scenario: Testing parameter method with optional argument parameter name
    Given I have default sut
    When I execute "$sut_plugin=@sut.parameter[:sut_plugin]"
    Then "$sut_plugin" is set to string "testability-driver-qt-sut-plugin"
    
@pass
  Scenario: Testing parameter method with optional default value for parameter that does not exist
    Given I have default sut
    When I execute "$product=@sut.parameter[:my_parameter, 'default']"
    Then "$product" is set to string "default"
    

