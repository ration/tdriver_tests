@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::SUT#group_behaviours
  As a test scripter writer
  I want to use group_behaviours method to group behaviours into a single message in testapp
  so that I can test the MobyBehaviour::QT::SUT behaviour

  Scenario: Testing group_behaviours method
    Given I launch application "calculator" as "@app"
    When I execute 
    """
      @__sut.group_behaviours(0.1,@app){
        @app.Button( :name => 'oneButton').tap
        @app.Button( :name => 'plusButton').tap 
        @app.Button( :name => 'twoButton').tap 
        @app.Button( :name => 'equalButton').tap}
    """
    Then The calculator display says "3"

