@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Webkit#tap
  As a test scripter writer
  I want to tap web elements
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: tap visible link
    Given I launch application "testapp"
    Then I move to webkit screen
    When I execute "@app.a(:elementText => 'test link2').tap"
    Then I verify that "a" is having "elementText" with value "return link"
  
  Scenario: tap unvisisble link
    Given I launch application "testapp"
    Then I move to webkit screen
    When I execute "@app.a(:elementText => 'not visible test link').tap"
    Then I verify that "a" is having "elementText" with value "return link"

  Scenario: tap second unvisisble link
    Given I launch application "testapp"
    Then I move to webkit screen
    When I execute "@app.a(:elementText => 'second not visible test link').tap"
    Then I verify that "a" is having "elementText" with value "return link"