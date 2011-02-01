@qt_symbian 

Feature: MobyBehaviour::Symbian::SUT#rotate_screen
  As a test script writer
  I want to launch a symbian application with UID
  so that I can test applications 

  Scenario: Successful launch of calculator with UID 0x2003c72d
    Given I have default sut
    Then I execute "@app = @sut.launch_with_uid({:UID=>'0x2003c72d'})"
    Then I add "@app" to close list
    Then application "calculator" is running
    
  @no_doc
  Scenario: Unsuccessful launch of application with UID 0x2003c72f
    Given I have default sut
    Then I execute 
      """
        verify_not() {@app = @sut.launch_with_uid({:UID=>'0x2003c72f'})}
      """
    

