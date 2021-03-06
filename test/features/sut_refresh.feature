@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#refresh
  As a test scripter writer
  I want to use refresh method to refresh the sut ui state
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing refresh method with required argument(s) (Rename this to be more descriptive)
    Given I have default sut
    When I execute "@sut.refresh"
    Then exception is not thrown

#  Scenario: Testing refresh method with optional argument 'refresh_args' (Rename this to be more descriptive)
#    Given I launch application [APPLICATION_NAME] as @app
#    When I execute "@app.[SOME_OBJECT].refresh(refresh_args)"
#    Then [ADD_YOUR_VERIFICATION_HERE]

