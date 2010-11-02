@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Application#drag
  As a test scripter writer
  I want to use drag method to move the trianlge in testapp
  so that I can test the MobyBehaviour::QT::Application behaviour

  Scenario: Testing drag method without duration
    Given I launch application "testapp" as "@app"
    When I execute "@app.Triangle( :name=>'Triangle1' ).drag(:Up, 257)"
    Then exception is not thrown
