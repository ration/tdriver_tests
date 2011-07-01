@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Attribute#set_attribute
  As a test script writer
  I want to use set_attribute method to set object attributes in testapp
  so that I can test the MobyBehaviour::QT::Attribute behaviour

  Scenario: The set_attribute method deduces the attribute data type from the argument class by default.
    Given I launch application "testapp" as "@app"
    When I execute "@app.Control( :name => 'Crash' ).set_attribute('x', 150)"
    Then the Control with name Crash has the attribute Qt_x with the value 150

  Scenario: Setting attribute value with attribute name as Symbol
    Given I launch application "testapp" as "@app"
    When I execute "@app.Control( :name => 'Crash' ).set_attribute(:x, 225)"
    Then the Control with name Crash has the attribute Qt_x with the value 225

  Scenario: The attribute type can also be given with the optinal type argument. This is required for more complex attribute types.
    Given I launch application "testapp" as "@app"
    When I execute "@app.Control(:name => 'Crash').set_attribute('pos', '200,250', 'QPoint')"    
	  Then the Control with name Crash has the attribute Qt_x with the value 200
	  And the Control with name Crash has the attribute Qt_y with the value 250

  Scenario: The set_attribute method works for proxy elements
    Given I launch application "testapp" as "@app"
    When I execute "@app.QLineEdit.set_attribute('text', '1/1/1')"
    Then the QLineEdit with name qt_spinbox_lineedit has the attribute text with the value 1/1/1

  Scenario: Setting attribute value with variable type of TrueClass
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].set_attribute(attribute, value)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Setting attribute value with variable type of FalseClass
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].set_attribute(attribute, value)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Setting attribute value with variable type of Date
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].set_attribute(attribute, value)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Setting attribute value with variable type of Time
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].set_attribute(attribute, value)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Setting attribute value with variable type of DateTime
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].set_attribute(attribute, value)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  @nodoc
  Scenario: Objects containing escape character (ASCII #27) in attribute value must be encoded as "\e" (bugfix)
    Given I launch application "calculator" as "@app"
    When I test code "@app.QLineEdit.set_attribute(:text, 'escape ' << 27.chr)"
    Then verify "@app.QLineEdit.attribute(:text) == 'escape '"
    And exception is not thrown

  @nodoc
  Scenario: Non-printable value (ASCII #1) will be stripped from objects attribute value (bugfix)
    Given I launch application "calculator" as "@app"
    When I test code "@app.QLineEdit.set_attribute(:text, 'ascii ' << 01.chr)"
    Then verify "@app.QLineEdit.attribute(:text) == 'ascii '"
    And exception is not thrown

