@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#frozen
  As a test scripter writer
  I want to use frozen attribute to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing frozen attribute 
    Given I have default sut
    When I execute "$is_frozen=@sut.frozen"
    Then verify "$is_frozen==false"
    
  Scenario: Testing frozen attribute after calling freeze
    Given I have default sut
    When I execute 
    """
	#freeze the sut
	@sut.freeze
	
	$is_frozen=@sut.frozen
	"""
    Then verify "$is_frozen==true"

