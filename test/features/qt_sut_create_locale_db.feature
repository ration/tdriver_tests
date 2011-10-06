@qt_linux @qt_windows

Feature: MobyBehaviour::QT::LocalisationDB#create_locale_db
  As a test scripter writer
  I want to use create_locale_db method to create a translation table in an sql database
  so that I can test the MobyBehaviour::QT::SUT behaviour

  # == Creation of localization tables
  # This scenarios will test a number of things
  # 1) table creation code
  # 2) column names for languages like 'id' don't interfere with table structure
  # 3) mapping of column names by user provided hash
  # 4) setting default priority for length variants when not provided in the translation files
  # 5) setting default plurality for numerus variants when not provided in the translation files
  # by using crafted values on the test data language files (settings_en.ts and settings_id.ts) 
  # used to generate a new translation table
  

  @mysql
  Scenario: Create a new localisation table with the translation file provided on a mysql db
    Given I have default sut
    And I set localisation parameters for mysql table creation  
    When I execute "@sut.create_locale_db(File.join(Dir.pwd, 'test_data'), '*.ts', nil, {'en' => 'en_GB'})"
    Then I set the language to "en_GB"
    And I can get the lengthvariant "1" with the translation "Settings" for the symbol "qtn_sett_main_title"
    And I can get the lengthvariant "2" with the translation "Sett." for the symbol "qtn_sett_main_title"
    And I can get the plurality "1" with the translation "Setting" for the symbol "qtn_sett_main_other"
    And I can get the plurality "2" with the translation "%L1 Settings" for the symbol "qtn_sett_main_other"
    And I can get the plurality "3" with the translation "All Settings" for the symbol "qtn_sett_main_other"
    And I set the language to "id"
    And I can get the lengthvariant "1" with the translation "Settings" for the symbol "qtn_sett_main_title"
    And I can get the lengthvariant "2" with the translation "Sett." for the symbol "qtn_sett_main_title"
    And I can get the plurality "1" with the translation "Setting" for the symbol "qtn_sett_main_other"
    And I can get the plurality "2" with the translation "%L1 Settings" for the symbol "qtn_sett_main_other"
    And I can get the plurality "3" with the translation "All Settings" for the symbol "qtn_sett_main_other"
    And I restore the language to default
    And I can drop the new table
    
  @sqlite
  Scenario: Create a new localisation table with the translation file provided on a sqlite db
    Given I have default sut
    And I set localisation parameters for sqlite table creation
    When I execute "@sut.create_locale_db(File.join(Dir.pwd, 'test_data'), '*.ts', nil, {'en' => 'en_GB'})"
    Then I set the language to "en_GB"
    And I can get the lengthvariant "1" with the translation "Settings" for the symbol "qtn_sett_main_title"
    And I can get the lengthvariant "2" with the translation "Sett." for the symbol "qtn_sett_main_title"
    And I can get the plurality "1" with the translation "Setting" for the symbol "qtn_sett_main_other"
    And I can get the plurality "2" with the translation "%L1 Settings" for the symbol "qtn_sett_main_other"
    And I can get the plurality "3" with the translation "All Settings" for the symbol "qtn_sett_main_other"
    And I set the language to "id"
    And I can get the lengthvariant "1" with the translation "Settings" for the symbol "qtn_sett_main_title"
    And I can get the lengthvariant "2" with the translation "Sett." for the symbol "qtn_sett_main_title"
    And I can get the plurality "1" with the translation "Setting" for the symbol "qtn_sett_main_other"
    And I can get the plurality "2" with the translation "%L1 Settings" for the symbol "qtn_sett_main_other"
    And I can get the plurality "3" with the translation "All Settings" for the symbol "qtn_sett_main_other"
    And I restore the language to default
    And I can delete the new table
    
  @mysql
  Scenario: Create a new localisation table with the .loc files on a mysql db using column name map
    Given I have default sut
    And I set localisation parameters for mysql table creation  
    When I execute "@sut.create_locale_db(File.join(Dir.pwd, 'test_data'), '*.loc', nil, {'01' => 'en_GB'})"
    And I can get the translation "#accindicatorsettings" for the symbol "STRING_r_short_caption"
    And I can drop the new table
    
  @mysql
  Scenario: Create a new localisation table with the .loc files on a mysql db
    Given I have default sut
    And I set localisation parameters for mysql table creation  
    When I execute "@sut.create_locale_db(File.join(Dir.pwd, 'test_data'), '*.loc')"
    And I set the language to "en"
    And I can get the translation "#accindicatorsettings" for the symbol "STRING_r_short_caption"
    And I restore the language to default
    And I can drop the new table
