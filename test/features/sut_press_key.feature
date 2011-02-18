@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::SUT#press_key
  As a test scripter writer
  I want to use press_key method to press a key in the calculator application
  so that I can test the MobyBehaviour::SUT behaviour

  Scenario: Testing press_key method on specified key
    Given I have default sut
    And I launch application "calculator"
    When I execute "@sut.press_key(:k1)"
    Then exception is not thrown

  Scenario: Testing press_key method with key sequence
    Given I have default sut
    And I launch application "calculator"
    When I execute "@sut.press_key( MobyCommand::KeySequence.new( :k1 ).append!( :k1 ) )"
    Then exception is not thrown

  Scenario: Testing press_key method on Qt specified key
    Given I have default sut
    And I launch application "calculator"
    When I execute "@sut.press_key(:qt_k1)"
    Then exception is not thrown

  Scenario: Testing press_key method with key sequence with Qt specified keys
    Given I have default sut
    And I launch application "calculator"
    When I execute "@sut.press_key( MobyCommand::KeySequence.new( :qt_k1 ).append!( :qt_k1 ) )"
    Then exception is not thrown

