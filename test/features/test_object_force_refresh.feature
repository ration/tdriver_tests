@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#force_refresh
  As a test scripter writer
  I want to use force_refresh method to forcibly refresh test object/application ui state
  so that I can test the MobyBehaviour::TestObject behaviour

  @nodoc
  Scenario: Testing force_refresh method with default argument
    Given I launch application "calculator" as "@app"
    When I execute
    """
        # set attribute does not refresh ui state
        @app.set_attribute('objectName', 'kalkulator')

        # verify that attribute 'objectName' has value 'calculator' 
        verify_true( 0, 'did not found objectName with calculator as value' ){ @app.xml_data.to_s.match(/\<attr.*?\>calculator\<\/attr.*?\>/) != nil } 

        @app.force_refresh

        # verify that attribute 'objectName' has value 'kalkulator' 
        verify_true( 0, 'did not found objectName with calculator as value' ){ @app.xml_data.to_s.match(/\<attr.*?\>kalkulator\<\/attr.*?\>/) != nil } 
    """
    Then exception is not thrown

  @nodoc
  Scenario: Testing force_refresh method with optional argument
    Given I launch application "calculator" as "@app"
    When I execute
    """
        # set attribute does not refresh ui state
        @app.set_attribute('objectName', 'kalkulator')

        # verify that attribute 'objectName' has value 'calculator' 
        verify_true( 0, 'did not found objectName with calculator as value' ){ @app.xml_data.to_s.match(/\<attr.*?\>calculator\<\/attr.*?\>/) != nil } 

        @app.force_refresh(:objectName=>'kalkulator')

        # verify that attribute 'objectName' has value 'kalkulator' 
        verify_true( 0, 'did not found objectName with calculator as value' ){ @app.xml_data.to_s.match(/\<attr.*?\>kalkulator\<\/attr.*?\>/) != nil } 
    """
    Then exception is not thrown

  @nodoc
  Scenario: (bugfix) TestObject#force_refresh with argument must not fail with multiple test object  
    Given I launch application "calculator" as "@app1"
    When I execute
    """
        @button1 = @app1.Button(:name=>'oneButton')
        @button2 = @app1.Button(:name=>'twoButton')
        @button1.force_refresh(:text=>'1')
        @button2.force_refresh(:text=>'2')
    """
    Then exception is not thrown

  @nodoc
  Scenario: (bugfix) TestObject#force_refresh must not fail with multiple test object   
    Given I launch application "calculator" as "@app1"
    When I execute
    """
        @button1 = @app1.Button(:name=>'oneButton')
        @button2 = @app1.Button(:name=>'twoButton')
        @button1.force_refresh 
        @button2.force_refresh 
    """
    Then exception is not thrown

  @nodoc
  Scenario: (bugfix) TestObject#force_refresh must not fail with multiple application  
    Given I launch application "testapp" as "@app1"
    Given I launch application "calculator" as "@app2"
    When I execute
    """
        @app1.force_refresh
        @app2.force_refresh
    """
    Then exception is not thrown

  @nodoc
  Scenario: (bugfix) TestObject#force_refresh with argument must not fail with multiple application  
    Given I launch application "testapp" as "@app1"
    Given I launch application "calculator" as "@app2"
    When I execute
    """
        @app1.force_refresh(:name=>'testapp')
        @app2.force_refresh(:name=>'calculator')
    """
    Then exception is not thrown

