@qt_linux, @qt_windows, @qt_symbian, @qt_meego

Feature: TestObject::tap
	As a test scripter writer
	I want to use tap method to tap objects in applications
	so that I can test the application behaviour


	Scenario: Tap in the middle of an object
		Given I launch application "calculator"
        When I execute "@app.Button(:name => 'oneButton').tap"
        Then The calculator display says "1"

@nodoc
	Scenario: Tap in the middle of an object
		Given I launch application "calculator" as "@app2"
        When I execute "@app2.Button(:name => 'oneButton').tap"
        Then The calculator display says "1"

@nodoc
	Scenario: Tap in the middle of an object
		Given I launch application "calculator" as "@app3" on sut "sut_qt"
        When I execute "@app3.Button(:name => 'oneButton').tap"
        Then The calculator display says "1"

