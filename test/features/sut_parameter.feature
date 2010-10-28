@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::SUT#parameter
  As a test scripter writer
  I want to use parameter method to access sut specific parameters
  so that I can test the MobyBehaviour::SUT behaviour

@pass
  Scenario: Pring all parameters (Hash) of current SUT
    Given I have default sut
    When I execute "@result = @sut.parameter"
    Then return value "@result" is kind of "MobyUtil::ParameterHash"

@pass
  Scenario: Retrieve a parameter value from current SUT
    Given I have default sut
    And I set new sut parameter "value_name" to "result_value"
    When I execute "@result = @sut.parameter[ 'value_name' ]"
    Then "@result" is set to string "result_value"
    
@pass
  Scenario: Retrieve a parameter value from current SUT, return default value (second argument) if not found
    Given I have default sut
    When I execute "@product = @sut.parameter[ 'my_parameter', 'default' ]"
    Then "@product" is set to string "default"
    
@pass
  Scenario: Set parameter value in current SUT
    Given I have default sut
    When I execute "@sut.parameter[ 'my_parameter_another' ] = 'my_value'"
    Then parameter "my_parameter_another" should have value "my_value"

