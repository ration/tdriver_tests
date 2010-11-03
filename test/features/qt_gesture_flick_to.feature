Feature: MobyBehaviour::QT::Gesture#flick_to
  As a test script writer
  I want to use flick_to method to move an object to a location in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

@qt_linux @qt_windows @qt_meego @qt_symbian
  Scenario: The flick_to method requires that a target coordinate point is given
    Given I launch application "testapp" as "@app"	
    When I execute "@app.Node.flick_to( 100, 100 )"    
    Then the new absolute location of the Node is 100, 100

@qt_linux @qt_windows @qt_meego @qt_symbian			
  Scenario: The button used when flicking can be defined
    Given I launch application "testapp" as "@app"	
    When I execute "@app.Node.flick_to( 100, 100, :Left )"    
    Then the new absolute location of the Node is 100, 100

@qt_linux @qt_windows @nodoc
  Scenario: The 'optional_params' argument can be used to set :use_tap_screen
    Given I launch application "testapp" as "@app"	
    And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.flick_to( 350, 400, , :Left, { :use_tap_screen => 'true' })"    
    Then the new absolute location of the Node is 350, 400

