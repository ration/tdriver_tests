Feature: MobyBehaviour::QT::FileTransfer#list_files_from_sut
  As a test scripter writer
  I want to use list_files_from_sut method to list files from sut
  so that I can test the MobyBehaviour::QT::FileTransfer behaviour

@qt_windows
  Scenario: List files from sut with list_files_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:from => 'test_files', :to => 'C:\\temp\\test_copy\\')"
    And exception is not thrown
    And I can delete the test files
    When I execute "@file_list = @sut.list_files_from_sut(:from => 'C:\\temp\\test_copy\\')"
    And exception is not thrown
    Then the files are listed from "C:\temp\test_copy\"
    And I test code "@sut.delete_from_sut(:from => 'C:\\temp\\test_copy\\', :file => '*.txt')"
    And exception is not thrown
    Then the file "test_file_1.txt" is not found from "C:\\temp\\test_copy\\" in sut
    Then the file "test_file_10.txt" is not found from "C:\\temp\\test_copy\\" in sut

@qt_linux @qt_meego
  Scenario: List files from sut with list_files_from_sut method
    Given I have default sut
    And I generate test files
    And I test code "@sut.copy_to_sut(:from => 'test_files', :to => '/tmp/test_copy/')"
    And exception is not thrown
    And I can delete the test files
    When I execute "@file_list = @sut.list_files_from_sut(:from => '/tmp/test_copy/')"
    And exception is not thrown
    Then the files are listed from "/tmp/test_copy/"
    And I test code "@sut.delete_from_sut(:from => '/tmp/test_copy/', :file => '*.txt')"
    And exception is not thrown
    Then the file "test_file_1.txt" is not found from "/tmp/test_copy/" in sut
    Then the file "test_file_10.txt" is not found from "/tmp/test_copy/" in sut
