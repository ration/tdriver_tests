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
    Then exception type of "MobyUtil::ParameterNotFoundError" is thrown

  Scenario: Retrieving non existing parameter fails with [] method 
    Given I have parameter class initialized
    When I execute "$parameters['test']"
    Then exception type of "MobyUtil::ParameterNotFoundError" is thrown

  Scenario: Verify that hashes are converted to ParameterHash
    Given I have parameter class initialized
    When I execute "$parameters['test'] = {:example => 'hash'}"
    Then exception is not thrown
    Then verify "$parameters['test'].kind_of?( MobyUtil::ParameterHash )"
    And delete parameter "test"

  Scenario: Parameter hash can be cleared and restored
    Given I have parameter class initialized
    When I execute "$parameters.clear"
    Then exception is not thrown
    Then verify "$parameters.inspect == '{}'"
    Then I test code "$parameters.reset"
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
    When I execute "$parameters.hash"
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
    When I execute "$parameters.parse_file( 'tdriver_parameters.xml' )"
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

  Scenario: Parameters are merged when loading xml file
    Given I have parameter class initialized
    When I test code "$parameters.clear"
    Then verify "$parameters.keys.empty? == true"
    When I test code "$parameters.parse_file( 'tdriver_parameters.xml' )"
    Then exception is not thrown
    When I test code "@some_hash_key = $parameters.keys.collect{ | key | key if $parameters[ key ].kind_of?( MobyUtil::ParameterHash ) }.compact.first"
    Then exception is not thrown
    When I test code "@some_hash = $parameters[ @some_hash_key ].dup"
    Then exception is not thrown
    When I test code "$parameters.clear"
    Then verify "$parameters.keys.empty? == true"
    Then I test code "$parameters[ @some_hash_key ] = @some_hash.merge( :original_value => 'found' )"
    When I execute "$parameters.parse_file( 'tdriver_parameters.xml' )"
    Then exception is not thrown
    And verify "$parameters[ @some_hash_key ].keys.include?( :original_value ) == true"
    Then I test code "$parameters.reset"
    And verify "$parameters.keys.empty? == false"
    And verify "$parameters[ @some_hash_key ].keys.include?( :original_value ) == false"

  Scenario: Correct exception is raised if parsing non xml fails 
    Given I have parameter class initialized
    When I execute "$parameters.parse_file( File.join( MobyUtil::FileHelper.tdriver_home, 'sut_parameters.rb' ) )"
    Then exception type of "MobyUtil::ParameterFileParseError" is thrown

  Scenario: Correct exception is raised if parsing xml string fails 
    Given I have parameter class initialized
    When I execute "$parameters.parse_string( 'not_valid_xml' )"
    Then exception type of "MobyUtil::ParameterXmlParseError" is thrown

  Scenario: Exception is raised if xml file not found in command line argument
    Given I have parameter class initialized
    When I test code "ARGV.concat(['--tdriver_parameters', 'missing.xml'])"
    When I execute "$parameters.__send__(:parse_command_line_arguments)"
    Then exception type of "MobyUtil::FileNotFoundError" is thrown
    Then I test code "ARGV.clear"

  Scenario: Exception is raised if xml file not defined in command line argument
    Given I have parameter class initialized
    When I test code "ARGV.concat(['--tdriver_parameters'])"
    When I execute "$parameters.__send__(:parse_command_line_arguments)"
    Then exception type of "ArgumentError" is thrown
    Then I test code "ARGV.clear"

  Scenario: Verify that filenames is parsed from command line argument
    Given I have parameter class initialized
    When I test code "@some_xml_file = $parameters.files.first"
    When I test code "ARGV.concat(['--tdriver_parameters', @some_xml_file ])"
    Then I execute "@arguments = $parameters.__send__(:parse_command_line_arguments)"
    And verify "@arguments.count == 1"
    And verify "@arguments.first == @some_xml_file"
    Then I test code "ARGV.clear"

  Scenario: Exception is raised if xml file not defined in command line argument
    Given I have parameter class initialized
    When I test code "@some_xml_file = $parameters.files.first"
    When I test code "$parameters.clear"
    When I test code "ARGV.concat(['--tdriver_parameters', @some_xml_file])"
    When I test code "$parameters.__send__(:parse_command_line_arguments)"
    When I execute "$parameters.__send__(:reset_hashes, { :load_default_parameters => false, :load_user_parameters => false })"
    Then exception is not thrown
    And verify "$parameters.files.count == 1"
    And verify "$parameters.files.first == @some_xml_file"
    Then I test code "ARGV.clear"
    Then I test code "$parameters.reset"
