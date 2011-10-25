@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::QT::Webkit#tap
  As a test scripter writer
  I want to tap web elements
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: tap visible link
    Given I launch browser
    When I execute "@app.a(:elementText => 'test link2').tap"
    Then I verify that "a" is having "elementText" with value "return link"
  
  Scenario: tap unvisible link
    Given I launch browser
    When I execute "@app.a(:elementText => 'not visible test link').tap"
    Then I verify that "a" is having "elementText" with value "return link"

  Scenario: tap second unvisible link
    Given I launch browser
    When I execute "@app.a(:elementText => 'second not visible test link').tap"
    Then I verify that "a" is having "elementText" with value "return link"