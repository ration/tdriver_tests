Feature: MobyBehaviour::QT::FileTransfer#copy_from_sut
  As a test scripter writer
  I want to use copy_from_sut method to copy files from sut
  so that I can test the MobyBehaviour::QT::FileTransfer behaviour

  Scenario: Copy file from sut with copy_from_sut method
    Given I have default sut
    And I generate test files
    When I execute "@app.[SOME_OBJECT].copy_from_sut(arguments)"
    Then [ADD_YOUR_VERIFICATION_HERE]

