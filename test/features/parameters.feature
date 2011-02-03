@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyUtil::Parameter
  As a test scripter writer
  I want to use parameter instance methods to perform different actions to parameters
  so that I can test the MobyUtil::Parameter behaviour

  Scenario: Verify that parameter with nil as key cannot be set
    Given I have parameter class initialized
    When I execute "$parameters[nil]='fails'"
    Then exception is thrown

  Scenario: Accessing parameters with global variable
    Given I have parameter class initialized
    When I execute "$parameters['test'] = 'example'"
    Then exception is not thrown
    Then verify "$parameters['test'] == 'example'"
    And delete parameter "test"

  Scenario: Retrieving parameter with fetch method
    Given I have parameter class initialized
    When I execute "$parameters['test'] = 'example'"
    Then exception is not thrown
    Then verify "$parameters.fetch('test') == 'example'"
    And delete parameter "test"

  Scenario: Default value is returned if given 
    Given I have parameter class initialized
    Then verify "$parameters['test', 'default_[]_value'] == 'default_[]_value'"
    And verify "$parameters.fetch('test', 'default_fetch_value') == 'default_fetch_value'"
    Then exception is not thrown

  Scenario: Block is executed when fetch fails and default value is not given 
    Given I have parameter class initialized
    And verify "$parameters.fetch('test'){ 'block_return_value' } == 'block_return_value'"
    Then exception is not thrown
    
  Scenario: Retrieving non existing parameter fails with fetch method 
    Given I have parameter class initialized
    When I execute "$parameters.fetch('test')"
    Then exception is thrown

  Scenario: Retrieving non existing parameter fails with [] method 
    Given I have parameter class initialized
    When I execute "$parameters['test']"
    Then exception is thrown

  Scenario: Verify that hashes are converted to ParameterHash
    Given I have parameter class initialized
    When I execute "$parameters['test'] = {:example => 'hash'}"
    Then exception is not thrown
    Then verify "$parameters['test'].kind_of?( MobyUtil::ParameterHash )"
    And delete parameter "test"

  Scenario: Parameter hash can be cleared and restored
    Given I have parameter class initialized
    When I execute "$parameters.instance.clear"
    Then exception is not thrown
    Then verify "$parameters.inspect == '{}'"
    Then I test code "$parameters.instance.reset_parameters"
    And verify "$parameters.inspect != '{}'"

  Scenario: Parameter hash is accessible directly
    Given I have parameter class initialized
    When I execute "$parameters.parameters"
    Then exception is not thrown

  Scenario: Parameter should contain list configured suts
    Given I have parameter class initialized
    When I execute "@sut_list = $parameters.configured_suts"
    Then exception is not thrown
    And verify "@sut_list.kind_of?( Array ) == true"

  Scenario: Parameter should contain list loaded files
    Given I have parameter class initialized
    When I execute "@sut_list = $parameters.files"
    Then exception is not thrown
    And verify "@sut_list.kind_of?( Array ) == true"



#  Scenario: Retrieve a parameter value from current SUT
#    Given I have default sut
#    And I set new sut parameter "value_name" to "result_value"
#    When I execute "@result = @sut.parameter[ 'value_name' ]"
#    Then verify "@result=='result_value'"
    
#  Scenario: Retrieve a parameter value from current SUT, return default value (second argument) if not found
#    Given I have default sut
#    When I execute "@result = @sut.parameter[ 'my_parameter', 'default' ]"
#    Then verify "@result=='default'"
    
#  Scenario: Set parameter value in current SUT
#    Given I have default sut
#    When I execute "@sut.parameter[ 'my_parameter_another' ] = 'my_value'"
#    Then parameter "my_parameter_another" should have value "my_value"

#tests:
# ?? - merge hash with hash --> parameter hash
# ok - access from MobyUtil::Parameter[]
# ok - access from MobyUtil::Parameter[]=
# ok - add hash to parameter, verify that returns parameter hash
# ok - parameter value type of hash is type of parameter hash
# ok - clear parameters (empty)
# ok - inspect returns string inspection
# ok - parameter not found error
# ok - MobyUtil::Parameter[nil]= raises exception
# ok - reset parameters (clear + reload)
# ok - MobyUtil::Parameter.parameters hash is accessible
# ok - configured_suts
# ok - loaded files


#- command line arguments

#- api#[]
#- api#fetch
#- api#[]=
#- api#files
#- api#clear
#- api#load_xml
#- api#reset
#- api#inspect
#- api#to_s

#- load parameters xml
# ?? - to_s 
#- parameter file parse error
#- template not found error
#- template file not loaded
