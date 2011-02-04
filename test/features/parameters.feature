@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyUtil::Parameter
  As a test scripter writer
  I want to use parameter instance methods to perform different actions to parameters
  so that I can test the MobyUtil::Parameter behaviour

  Scenario: Parameter inspection string representation of hash
    Given I have parameter class initialized
    Then verify "( $parameters.inspect =~ /^\{.*\}$/ ) != nil"

  Scenario: Parameter string representation of hash
    Given I have parameter class initialized
    Then verify "( $parameters.inspect =~ /^\{.*\}$/ ) != nil"

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

  Scenario: Parameter hash can be cleared and restored with static methods
    Given I have parameter class initialized
    When I execute "$parameters.clear"
    Then exception is not thrown
    Then verify "$parameters.inspect == '{}'"
    Then I test code "$parameters.reset"
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

  Scenario: Parameter keys can be listed
    Given I have parameter class initialized
    Then verify "$parameters.keys.kind_of?( Array ) == true"

  Scenario: Parameter values can be listed
    Given I have parameter class initialized
    Then verify "$parameters.values.kind_of?( Array ) == true"

  Scenario: Additional parameters files can be loaded on demand
    Given I have parameter class initialized
    When I test code "$parameters.clear"
    Then verify "$parameters.keys.empty? == true"
    When I execute "$parameters.instance.load_parameters_xml( 'tdriver_parameters.xml' )"
    Then exception is not thrown
    Then verify "$parameters.keys.empty? == false"
    Then I test code "$parameters.reset"
    And verify "$parameters.keys.empty? == false"

  Scenario: Additional parameters files can be loaded on demand by using static method parse_file
    Given I have parameter class initialized
    When I test code "$parameters.clear"
    Then verify "$parameters.keys.empty? == true"
    When I execute "$parameters.parse_file( 'tdriver_parameters.xml' )"
    Then exception is not thrown
    Then verify "$parameters.keys.empty? == false"
    Then I test code "$parameters.reset"
    And verify "$parameters.keys.empty? == false"

  Scenario: Loading missing parameters file raises exception
    Given I have parameter class initialized
    When I execute "$parameters.parse_file( 'missing_file.xml' )"
    Then exception is thrown

  Scenario: Additional parameters xml can be parsed on demand by using static method parse_string
    Given I have parameter class initialized
    And delete parameter :test
    When I execute "$parameters.parse_string( '<parameters><parameter name=\'test\' value=\'parsing\' /></parameters>' )"
    Then exception is not thrown
    Then verify "$parameters.keys.include?( :test ) == true"
    And delete parameter :test
    Then verify "$parameters.keys.include?( :test ) == false"

  Scenario: Additional parameters xml is merged when calling parse_string with default arguments
    Given I have parameter class initialized
    When I test code "$parameters[ :test ] = { :original => 'hash' }"
    Then exception is not thrown
    And I execute "$parameters.parse_string( '<parameters><test><parameter name=\'merged\' value=\'parameter\' /></test></parameters>' )"
    Then exception is not thrown
    Then verify "$parameters[ :test ].kind_of?( MobyUtil::ParameterHash ) == true"
    And verify "$parameters[ :test ].keys.include?( :original ) == true"
    And verify "$parameters[ :test ].keys.include?( :merged ) == true"
    And delete parameter :test
    Then verify "$parameters.keys.include?( :test ) == false"

  Scenario: Additional parameters xml overwrites existing values when calling parse_string
    Given I have parameter class initialized
    When I test code "$parameters[ :test ] = { :original => 'hash' }"
    Then exception is not thrown
    And I execute "$parameters.parse_string( '<parameters><test><parameter name=\'merged\' value=\'parameter\' /></test></parameters>', false )"
    Then exception is not thrown
    Then verify "$parameters[ :test ].kind_of?( MobyUtil::ParameterHash ) == true"
    And verify "$parameters[ :test ].keys.include?( :original ) == false"
    And verify "$parameters[ :test ].keys.include?( :merged ) == true"
    And delete parameter :test
    Then verify "$parameters.keys.include?( :test ) == false"


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
# ok - api#load_xml
# ok - load parameters xml

# missing:
# - command line arguments
# - parameter file parse error
# - template not found error
# - template file not loaded

# ?? - to_s 
# ?? - merge hash with hash --> parameter hash

