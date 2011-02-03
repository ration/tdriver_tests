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
    Then verify "$parameters.configured_suts.kind_of?( Array ) == true"

  Scenario: Parameter should contain list loaded files
    Given I have parameter class initialized
    Then verify "$parameters.files.kind_of?( Array ) == true"

  Scenario: Retrieve parameter by using public end-user API
    Given I have parameter class initialized
    When I execute "$parameters['test'] = 'example'"
    Then exception is not thrown
    And verify "TDriver.parameter('test') == 'example'"
    And delete parameter "test"

  Scenario: Retrieve default value of non existing parameter by using public end-user API
    Given I have parameter class initialized
    Then exception is not thrown
    And verify "TDriver.parameter('test', 'example') == 'example'"

  Scenario: Retrieve parameter with fetch method by using public end-user API
    Given I have parameter class initialized
    When I execute "$parameters['test'] = 'another_example'"
    Then exception is not thrown
    And verify "TDriver.parameter.fetch('test') == 'another_example'"
    And delete parameter "test"

  Scenario: Retrieve default value of non existing parameter with fetch method by using public end-user API
    Given I have parameter class initialized
    Then exception is not thrown
    And verify "TDriver.parameter.fetch('test', 'another_example') == 'another_example'"

  Scenario: Retrieve default value from block of non existing parameter with fetch method by using public end-user API
    Given I have parameter class initialized
    Then exception is not thrown
    And verify "TDriver.parameter.fetch('test'){ 'another_example' } == 'another_example'"

  Scenario: Set parameter by using public end-user API
    Given I have parameter class initialized
    When I execute "TDriver.parameter['test'] = 'another_example'"
    And verify "TDriver.parameter['test'] == 'another_example'"
    And delete parameter "test"

  Scenario: List loaded files by using public end-user API
    Given I have parameter class initialized
    Then verify "TDriver.parameter.files.kind_of?( Array ) == true"

  Scenario: List loaded files by using public end-user API
    Given I have parameter class initialized
    Then verify "TDriver.suts.kind_of?( Array ) == true"

  Scenario: Inspect parameters by using public end-user API
    Given I have parameter class initialized
    Then verify "( TDriver.parameter.inspect =~ /^\{.*\}$/ ) != nil"
    
  Scenario: Parameter hash can be cleared and restored by using public end-user API
    Given I have parameter class initialized
    When I execute "TDriver.parameter.clear"
    Then exception is not thrown
    Then verify "TDriver.parameter.inspect == '{}'"
    Then I test code "TDriver.parameter.reset"
    And verify "TDriver.parameter.inspect != '{}'"

# coverage:
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
# ok - api#[]
# ok - api#fetch
# ok - api#[]=
# ok - api#files
# ok - api#inspect
# ok - api#clear
# ok - api#reset

# missing:
# - command line arguments
# - api#load_xml
# - api#to_s
# - load parameters xml
# - parameter file parse error
# - template not found error
# - template file not loaded
# ?? - to_s 
# ?? - merge hash with hash --> parameter hash

