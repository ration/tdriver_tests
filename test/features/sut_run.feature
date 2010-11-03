@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#run
  As a test scripter writer
  I want to use run method to run application
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Start testable application using run method
    Given I have default sut
    When I execute "@app=@sut.run(:name => 'testapp')"
    And exception is not thrown
    Then testapp should be the top most application
    And I test code "@app.close"
    And application "testapp" is not running

