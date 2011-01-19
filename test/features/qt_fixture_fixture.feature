@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: MobyBehaviour::QT::Fixture#fixture
  As a test scripter writer
  I want to use fixture method to perform specific commands on the target
  so that I can test the MobyBehaviour::QT::Fixture behaviour

  Scenario: Set focus to a component using a fixture call
	Given I launch application "calculator"
  When I execute "@app.QLineEdit( :name => 'display' ).fixture('qt', 'setFocus')"
	Then QLinedit has focus

@nodoc
  Scenario: Test dynamic paramer for fixture
  Given I launch application "calculator"
  And I have default sut
  Then I clear fixture qt from parameters
  When I execute 
    """
    MobyUtil::Parameter[@sut.id.to_sym][:fixtures][:qt] = 'tasfixture'
    @app.QLineEdit( :name => 'display' ).fixture('qt', 'setFocus')
    """

