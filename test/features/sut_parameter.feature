@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::SUT#parameter
  As a test scripter writer
  I want to use parameter method to access sut specific parameters
  so that I can test the MobyBehaviour::SUT behaviour

@pass
  Scenario: Pring all parameters (Hash) of current SUT
    Given I have default sut
    When I execute "$parameter_hash = @sut.parameter"
    Then I get a Hash containing all sut parameters

@pass
  Scenario: Retrieve a parameter value from current SUT
    Given I have default sut
    When I execute "$sut_plugin = @sut.parameter[:sut_plugin]"
    Then "$sut_plugin" is set to string "testability-driver-qt-sut-plugin"
    
@pass
  Scenario: Retrieve a parameter value from current SUT, return default value (second argument) if not found
    Given I have default sut
    When I execute "$product = @sut.parameter['my_parameter', 'default']"
    Then "$product" is set to string "default"
    
@pass
  Scenario: Set parameter value in current SUT
    Given I have default sut
    When I execute "@sut.parameter['my_parameter_another']='my_value'"
    Then parameter "my_parameter_another" should have value "my_value"

