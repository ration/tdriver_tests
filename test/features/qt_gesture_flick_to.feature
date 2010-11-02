@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Gesture#flick_to
  As a test script writer
  I want to use flick_to method to move an object to a location in testapp
  so that I can test the MobyBehaviour::QT::Gesture behaviour

  Scenario: The flick_to method requires that a target coordinate point is given
    Given I launch application "testapp" as "@app"	
    And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.flick_to( 350, 400 )"    
    Then the new absolute location of the Node is 350, 400
			
  Scenario: The button used when flicking can be defined
    Given I launch application "testapp" as "@app"	
    And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.flick_to( 350, 400, :Left )"    
    Then the new absolute location of the Node is 350, 400

  @nodoc
  Scenario: The 'optional_params' argument can be used to set :use_tap_screen
    Given I launch application "testapp" as "@app"	
    And the MainWindow is at absolute location 100, 100"
    When I execute "@app.Node.flick_to( 350, 400, , :Left, { :use_tap_screen => 'true' })"    
    Then the new absolute location of the Node is 350, 400

