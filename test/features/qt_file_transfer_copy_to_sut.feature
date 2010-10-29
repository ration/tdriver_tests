Feature: MobyBehaviour::QT::FileTransfer#copy_to_sut
  As a test scripter writer
  I want to use copy_to_sut method to copy files in to sut
  so that I can test the MobyBehaviour::QT::FileTransfer behaviour

@qt_windows 
  Scenario: Copy file to sut with copy_to_sut method
    Given I have default sut
    And I generate test files
    When I execute "@sut.copy_to_sut(:file => 'test_files\\test_file_1.txt', :to => 'C:\\temp\\')"
    Then exception is not thrown
    And the file "test_file_1.txt" is found from "C:\temp\" in sut
    And I can delete the file "test_file_1.txt" from "C:\temp\" in sut
    Then the file "test_file_1.txt" is not found from "C:\temp\" in sut
    And I can delete the test files

@qt_symbian
  Scenario: Copy file to sut with copy_to_sut method
    Given I have default sut
    And I generate test files
    When I execute "@sut.copy_to_sut(:file => 'test_files\\test_file_1.txt', :to => 'E:\\temp\\')"
    Then exception is not thrown
    And the file "test_file_1.txt" is found from "E:\temp\" in sut
    And I can delete the file "test_file_1.txt" from "E:\temp\" in sut
    Then the file "test_file_1.txt" is not found from "E:\temp\" in sut
    And I can delete the test files

@qt_linux @qt_meego
  Scenario: Copy file to sut with copy_to_sut method
    Given I have default sut
    And I generate test files
    When I execute "@sut.copy_to_sut(:file => 'test_files/test_file_1.txt', :to => '/tmp/')"
    Then exception is not thrown
    And the file "test_file_1.txt" is found from "/tmp/" in sut
    And I can delete the file "test_file_1.txt" from "/tmp/" in sut
    Then the file "test_file_1.txt" is not found from "/tmp/" in sut
    And I can delete the test files

