Feature: MobyBehaviour::QT::FileTransfer#copy_from_sut
  As a test scripter writer
  I want to use copy_from_sut method to copy files from sut
  so that I can test the MobyBehaviour::QT::FileTransfer behaviour

@qt_windows
  Scenario: Copy file from sut with copy_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:file => 'test_files\\test_file_1.txt', :to => 'C:\\temp\\test_copy\\')"
    And exception is not thrown
    And I can delete the test files
    When I execute "@sut.copy_from_sut(:from => 'C:\\temp\\test_copy\\', :file => 'test_file_1.txt', :to => 'C:\\temp\\copy\\')"
    Then exception is not thrown
    And the file "test_file_1.txt" is found from "C:\\temp\\copy\\" in sut
    And I test code "@sut.delete_from_sut(:dir => 'C:\\temp\\copy\\' )"
    And I test code "@sut.delete_from_sut(:dir => 'C:\\temp\\test_copy\\' )"

@qt_symbian
  Scenario: Copy file from sut with copy_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:file => 'test_files\\test_file_1.txt', :to => 'E:\\temp\\test_copy\\')"
    And exception is not thrown
    And I can delete the test files
    When I execute "@sut.copy_from_sut(:from => 'E:\\temp\\test_copy\\', :file => 'test_file_1.txt', :to => 'E:\\temp\\copy\\')"
    Then exception is not thrown
    And the file "test_file_1.txt" is found from "E:\\temp\\copy\\" in sut
    And I test code "@sut.delete_from_sut(:dir => 'E:\\temp\\copy\\' )"
    And I test code "@sut.delete_from_sut(:dir => 'E:\\temp\\test_copy\\' )"

@qt_linux
  Scenario: Copy file from sut with copy_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:file => 'test_files\\test_file_1.txt', :to => '/usr/share/temp/test_copy')"
    And exception is not thrown
    And I can delete the test files
    When I execute "@sut.copy_from_sut(:from => '/usr/share/temp/test_copy', :file => 'test_file_1.txt', :to => '/usr/share/temp/copy')"
    Then exception is not thrown
    And the file "test_file_1.txt" is found from "/usr/share/temp/copy" in sut
    And I test code "@sut.delete_from_sut(:dir => '/usr/share/temp/copy' )"
    And I test code "@sut.delete_from_sut(:dir => '/usr/share/temp/test_copy' )"

