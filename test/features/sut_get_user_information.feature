@qt_linux @qt_windows

Feature: MobyBehaviour::SUT#get_user_information
  As a test scripter writer
  I want to retrieve user information for the SUT
  so that I can test the MobyBehaviour::SUT behaviour
	
	@mysql
  Scenario: Retrieve user information on mysql for the sut
    Given I have default sut
    And I set localisation parameters for mysql test environment
	  When I execute "$translation = @sut.get_user_information(:uif_first_name)"
	  Then I get the translation "Ivan"

	@sqlite
  Scenario: Retrieve user information on sqlite for the sut
    Given I have default sut
    And I set localisation parameters for sqlite test environment
	  When I execute "$translation = @sut.get_user_information(:uif_first_name)"
	  Then I get the translation "Ivan"		