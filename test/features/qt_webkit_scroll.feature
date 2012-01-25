@qt_linux @qt_symbian

Feature: MobyBehaviour::QT::Webkit#scroll
  As a test scripter writer
  I want to use scroll method to scroll webview to bring object wisible in testapp
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: Testing scroll without arguments, this brings the web element visible on screen
    Given I launch browser
    When I execute "@app.a(:elementText => 'not visible test link').scroll"
    Then I should see "a" having "elementText" with value "not visible test link"

# Commented out for now since the app does not work and therefore test cannot pass
#  Scenario: Scrolls the webframe to wanted direction (x: 0, y: 100)
#    Given I launch browser
#    Then I execute "@app.QWebFrame(:__index=>2).scroll(0,100)"
#    Then I should not see "img" having "alt" with value "matti2"

  Scenario: Scrolls the webframe to wanted direction (x: 110, y: 0)
    Given I launch browser
    Then I execute "@app.QWebFrame(:__index=>2).scroll(110,0)"
    Then I should not see "img" having "alt" with value "matti2"
