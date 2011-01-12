@qt_linux @qt_windows

Feature: MobyBehaviour::SUT#get_operator_data
  As a test scripter writer
  I want to retrieve operator data for the SUT
  so that I can test the MobyBehaviour::SUT behaviour
	
	@mysql
  Scenario: Retrieve operator data on mysql for the sut
    Given I have default sut
    And I set localisation parameters for mysql test environment
	  When I execute "$translation = @sut.get_operator_data(:operator_welcome_message)"
	  Then I get the translation "Welcome to Orange"

	@sqlite
  Scenario: Retrieve operator data on sqlite for the sut
    Given I have default sut
    And I set localisation parameters for sqlite test environment
	  When I execute "$translation = @sut.get_operator_data(:operator_welcome_message)"
	  Then I get the translation "Welcome to Orange"		
	
	
	