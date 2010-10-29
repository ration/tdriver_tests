Feature: MobyBehaviour::QT::LocalisationDB#create_locale_db

  As a test scripter writer
  I want to use create_locale_db method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::SUT behaviour

  @mysql
  Scenario: Create a new localisation table with the translation file provided on a mysql db
    Given I have default sut
    And I set localisation parameters for mysql table creation
    When I execute "@sut.create_locale_db( Dir.pwd + '/test_data/' , '*.ts', nil, {'en' => 'en_GB'})"
    Then I can get the translation "Settings" from the new table
    And I can drop the new table

  @sqlite
  Scenario: Create a new localisation table with the translation file provided on a sqlite db
    Given I have default sut
    And I set localisation parameters for sqlite table creation
    When I execute "@sut.create_locale_db( Dir.pwd + '/test_data/' , '*.ts', nil, {'en' => 'en_GB'})"
    Then I can get the translation "Settings" from the new table
    And I can delete the new table
