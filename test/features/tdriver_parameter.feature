@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: TDriver.parameter
  As a test scripter writer
  I want to use parameter end-user API to perform different actions to parameters
  so that I can test the TDriver.parameter

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

  Scenario: Retrieve default value of non existing parameter by using [] method from public end-user API
    Given I have parameter class initialized
    Then exception is not thrown
    And verify "TDriver.parameter['test', 'example'] == 'example'"

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

  Scenario: Additional parameters files can be loaded on demand
    Given I have parameter class initialized
    When I test code "TDriver.parameter.clear"
    Then verify "TDriver.parameter.keys.empty? == true"
    When I execute "TDriver.parameter.load_xml( 'tdriver_parameters.xml' )"
    Then exception is not thrown
    Then verify "TDriver.parameter.keys.empty? == false"
    Then I test code "TDriver.parameter.reset"
    And verify "TDriver.parameter.inspect != '{}'"

# - api#to_s

