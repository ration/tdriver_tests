Feature: MobyBehaviour::SUT#translate
  As a test scripter writer
  I want to use translate method to get localised translations in testapp
  so that I can test the MobyBehaviour::SUT behaviour

  @mysql
  Scenario: Testing translate method with required argument on mysql
    Given I have default sut
	And I set localisation parameters for mysql test environment
    When I execute "$translation = @sut.translate(:txt_common_button_ok)"
    Then I get the translation "OK"
  
  @sqlite
  Scenario: Testing translate method with required argument on sqlite
    Given I have default sut
	And I set localisation parameters for sqlite test environment
    When I execute "$translation = @sut.translate(:txt_first_name)"
    Then I get the translation "Ivan"

  @mysql
  Scenario: Testing translate method with optional argument 'file_name' on mysql
    Given I have default sut
	And I set localisation parameters for mysql test environment
    When I execute "$translation = @sut.translate(:txt_common_button_ok, 'videos')"
    Then I get the translation "OK"

  @sqlite
  Scenario: Testing translate method with optional argument 'file_name' on sqlite
    Given I have default sut
	And I set localisation parameters for sqlite test environment
    When I execute "$translation = @sut.translate(:txt_first_name, 'videos')"
    Then I get the translation "Ivan"

  @mysql
  Scenario: Testing translate method when translations is missing on mysql
    Given I have default sut
	And I set localisation parameters for mysql test environment
    When I execute "$translation = @sut.translate(:dont_exist)"
	Then exception matching "No translation found for logical name 'dont_exist' in language 'English-GB' with given plurality" is thrown

  @sqlite
  Scenario: Testing translate method when translations is missing on sqlite
    Given I have default sut
	And I set localisation parameters for sqlite test environment
    When I execute "$translation = @sut.translate(:dont_exist)"
	Then exception matching "No translation found for logical name 'dont_exist' in language 'Catalan' with given plurality" is thrown
		
  @mysql
  Scenario: Open a application and retrieve a translation for User Information on mysql
    Given I have default sut
    And I set localisation parameters for mysql test environment
	When I execute "$translation = @sut.translate(:uif_first_name)"
	Then I get the translation "Ivan"

  @sqlite
  Scenario: Open a application and retrieve a translation for User Information on sqlite
    Given I have default sut
    And I set localisation parameters for sqlite test environment
	When I execute "$translation = @sut.translate(:uif_first_name)"
	Then I get the translation "Ivan"	

  @mysql
  Scenario: Testing translate method when multiple translations are returned on mysql 
    Given I have default sut
	And I set localisation parameters for mysql test environment
    When I execute "$translation = @sut.translate(:txt_common_button_clear)"
    Then I get an "Array" as a return type
	And I get the translation "Clear" on the first value of the returned Array

  @sqlite
  Scenario: Testing translate method when multiple translations are returned on sqlite 
    Given I have default sut
	And I set localisation parameters for sqlite test environment
    When I execute "$translation = @sut.translate(:txt_second_name)"
    Then I get an "Array" as a return type
	And I get the translation "Castane" on the first value of the returned Array
	
  @mysql
  Scenario: Testing translate method when multiple translations for User Information are returned on mysql 
    Given I have default sut
	And I set localisation parameters for mysql test environment
    When I execute "$translation = @sut.translate(:uif_second_name)"
    Then I get an "Array" as a return type
	And I get the translation "Castane" on the first value of the returned Array
	
  @sqlite
  Scenario: Testing translate method when multiple translations for User Information are returned on sqlite 
    Given I have default sut
	And I set localisation parameters for sqlite test environment
    When I execute "$translation = @sut.translate(:uif_second_name)"
    Then I get an "Array" as a return type
	And I get the translation "Castane" on the first value of the returned Array
	
  @mysql
  Scenario: Testing translate method with optional arguments fname, plurality and lengthvariant on mysql
    Given I have default sut
	And I set localisation parameters for mysql test environment
    When I execute "$translation = @sut.translate(:txt_plurality_test, 'calendar', 'a', nil, '1')"
	Then I get the translation "My dog eats %Ln cookies a day."
	
  @mysql
  Scenario: Testing translate method with optional arguments fname, plurality, numerus and lengthvariant on mysql
    Given I have default sut
	And I set localisation parameters for mysql test environment
    When I execute "$translation = @sut.translate(:txt_plurality_test, 'calendar', 'a', 3, '1')"
	Then I get the translation "My dog eats 3 cookies a day."
	
  @sqlite
  Scenario: Testing translate method with optional arguments fname, plurality and lengthvariant on sqlite
    Given I have default sut
	And I set localisation parameters for sqlite test environment
    When I execute "$translation = @sut.translate(:txt_plurality_test, 'calendar', 'a', nil, '1')"
	Then I get the translation "My dog eats %Ln cookies a day."
	
  @sqlite
  Scenario: Testing translate method with optional arguments fname, plurality, numerus and lengthvariant on sqlite
    Given I have default sut
	And I set localisation parameters for mysql test environment
    When I execute "$translation = @sut.translate(:txt_plurality_test, 'calendar', 'a', 3, '1')"
	Then I get the translation "My dog eats 3 cookies a day."

# Test Test Object identification and use (tap)
# find a test object with the dynamic attributes for translation (:__plurality, :__numerus, ...)
# MobyUtil::Parameter[ @sut.id ][ :read_lang_from_app ] true/false .. test may be related to a recent defect report