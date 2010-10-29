Feature: MobyBehaviour::QT::Webkit#scroll
  As a test scripter writer
  I want to use scroll method to scroll webview to bring object wisible in testapp
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: Testing scroll without arguments, this brings the web element visible on screen
    Given I launch application "testapp"
    Then I move to webkit screen
    When I execute "@app.a(:elementText => 'not visible test link').scroll()"
    Then I should see "a" having "elementText" with value "not visible test link"

  Scenario: Testing scroll with arguments, scrolls the webframe to wanted direction
    Given I launch application "testapp"
    Then I move to webkit screen
    Then I execute "@app.QWebFrame(:__index=>'2').scroll(0,150)"
    Then I should not see "img" having "alt" with value "matti3"

  Scenario: Testing scroll with arguments, scrolls the webframe to wanted direction
    Given I launch application "testapp"
    Then I move to webkit screen
    Then I execute "@app.QWebFrame(:__index=>'2').scroll(110,0)"
    Then I should not see "img" having "alt" with value "matti3"
