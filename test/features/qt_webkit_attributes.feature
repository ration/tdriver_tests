@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: Testing retrieving WebKit objects with attributes
  As a test scripter writer
  I want to check that all the webkit attributes are working correctly
  so that I can test the MobyBehaviour::QT::Webkit behaviour

  Scenario: After loading web element following elements should be available
    Given I launch browser
    Then I verify evaluate string "@app.input(:type => 'radio', :checked => 'false')"
    Then I verify evaluate string "@app.input(:type => 'radio', :checked => 'true')"
    Then I verify evaluate string "@app.p(:elementText => 'sample element text')"
    Then I verify evaluate string "@app.img(:alt => 'matti1')"
    Then I verify evaluate string "@app.img(:id => '2')"
    Then I verify evaluate string "@app.input(:id => 'textfield')"
    Then I verify evaluate string "@app.select(:value => 'Please Choose')"
    Then I verify evaluate string "@app.option(:value => '1', :selected => 'false')"
    Then I verify evaluate string "@app.button(:value => 'submit')"
