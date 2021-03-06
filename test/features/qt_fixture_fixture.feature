Feature: MobyBehaviour::QT::Fixture#fixture
  As a test scripter writer
  I want to use fixture method to perform specific commands on the target
  so that I can test the MobyBehaviour::QT::Fixture behaviour

@qt_linux @qt_windows @qt_symbian @qt_meego
  Scenario: Set focus to a component using a fixture call
  Given I launch application "calculator" as "@app"
  When I execute "@__sut.application(:name => 'calculator').QLineEdit(:name => 'display').fixture('qt', 'setFocus')"
  Then QLinedit has focus

@qt_linux @qt_windows @qt_symbian
  Scenario: Get appligation signals using a fixture call
  Given I launch application "testapp" with listening signals "applicationReady()"
  When I execute "@app_signals=@app.fixture('signal', 'get_signal')"
  Then the application should have applicationReady signals
  And I test code "@app.fixture('signal', 'remove_signals')"

@qt_linux @qt_windows @qt_meego @nodoc
  Scenario: Test dynamic parameter for fixture
  Given I launch application "calculator" as "@app"
  And I have default sut
  Then I clear fixture qt from parameters
  When I execute 
    """
    @sut.parameter[ :fixtures ][ :qt ] = 'tasfixture'
    @app.QLineEdit(:name => 'display').fixture('qt', 'setFocus')
    """

@qt_linux @qt_windows @qt_meego @nodoc
  Scenario: Set focus to a component via fixtures service class
  Given I launch application "calculator" as "@app"
  When I execute "@__sut.application(:name => 'calculator').QLineEdit(:name => 'display').fixtures.qt.setFocus"
  Then QLinedit has focus

