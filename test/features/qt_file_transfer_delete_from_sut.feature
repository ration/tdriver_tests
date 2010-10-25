Feature: MobyBehaviour::QT::FileTransfer#delete_from_sut
  As a test scripter writer
  I want to use delete_from_sut method to delete files from sut
  so that I can test the MobyBehaviour::QT::FileTransfer behaviour

@qt_windows
  Scenario: Delete file from sut with delete_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:file => 'test_files\\test_file_1.txt', :to => 'C:\\temp\\test_copy\\')"
    And exception is not thrown
    And I can delete the test files
    And the file "test_file_1.txt" is found from "C:\\temp\\test_copy\\" in sut
    When I execute "@sut.delete_from_sut(:file => 'C:\\temp\\test_copy\\test_file_1.txt')"
    Then the file "test_file_1.txt" is not found from "C:\\temp\\test_copy\\" in sut

@qt_windows
  Scenario: Delete files from sut with delete_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:from => 'test_files', :to => 'C:\\temp\\test_copy\\')"
    And exception is not thrown
    And I can delete the test files
    And the file "test_file_1.txt" is found from "C:\\temp\\test_copy\\" in sut
    And the file "test_file_10.txt" is found from "C:\\temp\\test_copy\\" in sut
    When I execute "@sut.delete_from_sut(:from => 'C:\\temp\\test_copy\\', :file => '*.txt')"
    And exception is not thrown
    Then the file "test_file_1.txt" is not found from "C:\\temp\\test_copy\\" in sut
    Then the file "test_file_10.txt" is not found from "C:\\temp\\test_copy\\" in sut

@qt_linux
  Scenario: Delete file from sut with delete_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:file => 'test_files\\test_file_1.txt', :to => '/usr/share/temp/test_copy')"
    And exception is not thrown
    And I can delete the test files
    And the file "test_file_1.txt" is found from "/usr/share/temp/test_copy" in sut
    When I execute "@sut.delete_from_sut(:file => '/usr/share/temp/test_copy/test_file_1.txt')"
    Then the file "test_file_1.txt" is not found from "/usr/share/temp/test_copy/" in sut

@qt_linux
  Scenario: Delete files from sut with delete_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:from => 'test_files', :to => '/usr/share/temp/test_copy/')"
    And exception is not thrown
    And I can delete the test files
    And the file "test_file_1.txt" is found from "/usr/share/temp/test_copy/" in sut
    And the file "test_file_10.txt" is found from "/usr/share/temp/test_copy/" in sut
    When I execute "@sut.delete_from_sut(:from => '/usr/share/temp/test_copy/', :file => '*.txt')"
    And exception is not thrown
    Then the file "test_file_1.txt" is not found from "/usr/share/temp/test_copy/" in sut
    Then the file "test_file_10.txt" is not found from "/usr/share/temp/test_copy/" in sut

@qt_symbian
  Scenario: Delete file from sut with delete_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:file => 'test_files\\test_file_1.txt', :to => 'C:\\temp\\test_copy\\')"
    And exception is not thrown
    And I can delete the test files
    And the file "test_file_1.txt" is found from "C:\\temp\\test_copy\\" in sut
    When I execute "@sut.delete_from_sut(:file => 'C:\\temp\\test_copy\\test_file_1.txt')"
    Then the file "test_file_1.txt" is not found from "C:\\temp\\test_copy\\" in sut
