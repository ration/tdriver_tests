@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#system_information
  As a test scripter writer RESERVED
  I want to use system_information method to query system information
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Retrieve all system information and extract total memory
    Given I have default sut
    When I execute "my_message = 'total mem: ' + @sut.system_information.MemoryStatus.attribute('total')"
    Then exception is not thrown
    
  Scenario: Retrieve all system information and extract available memory
    Given I have default sut
    When I execute "my_message = 'available mem: ' + @sut.system_information.MemoryStatus.attribute('available')"
    Then exception is not thrown

  Scenario: Retrieve all system information and extract agent memory usage
    Given I have default sut
    When I execute "my_message = 'qttas mem: ' + @sut.system_information.MemoryStatus.attribute('qttasMemUsage')"
    Then exception is not thrown