@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: TDriver verify
	As a TDriver script developer
	I want to be able to specify verify timeouts
	so that I can write good tests


Scenario: Specify verify_false timeout as 0
  Given I have default sut
  When I call verify_false with timeout 0
  Then the verify should timeout in 0
  

Scenario: Specify verify_false timeout as 3
  Given I have default sut
  When I call verify_false with timeout 3
  Then the verify should timeout in 3


Scenario: Specify verify_false timeout as nil
  Given I have default sut
  When I call verify_false with no timeout value
  Then the verify should timeout with default synchronization value


Scenario: Specify verify_true timeout as 0
  Given I have default sut
  When I call verify_true with timeout 0
  Then the verify should timeout in 0


Scenario: Specify verify_true timeout as 3
  Given I have default sut
  When I call verify_true with timeout 3
  Then the verify should timeout in 3


Scenario: Specify verify_true timeout as nil
  Given I have default sut
  When I call verify_true with no timeout value
  Then the verify should timeout with default synchronization value
  

Scenario: Specify verify_signal with message
  Given I have default sut
  When I launch application "calculator"
  Then I call verify_signal to catch signal clicked() with no message   

Scenario: Specify verify_signal with no message
  Given I have default sut
  When I launch application "calculator"
  Then I call verify_signal to catch signal clicked() with message "The zero button should be clicked"    

Scenario: User defined code block is executed (verify)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify that fails
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify passes (verify)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify that passes
  Then user defined code block won't be executed

Scenario: User defined code block is executed (verify_not)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify_not that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify_not)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify_not that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_not)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify_not that fails
  Then user defined code block won't be executed


Scenario: User defined code block is not executed when disabled and verify passes (verify_not)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify_not that passes
  Then user defined code block won't be executed


Scenario: User defined code block is executed (verify_true)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify_true that fails
  Then user defined code block will be executed


Scenario: User defined code block is not executed (verify_true)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify_true that passes
  Then user defined code block won't be executed


Scenario: User defined code block is not executed when disabled and verify fails (verify_true)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify_true that fails
  Then user defined code block won't be executed


Scenario: User defined code block is not executed when disabled and verify passes (verify_true)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify_true that passes
  Then user defined code block won't be executed


Scenario: User defined code block is executed (verify_false)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify_false that fails
  Then user defined code block will be executed


Scenario: User defined code block is not executed (verify_false)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify_false that passes
  Then user defined code block won't be executed


Scenario: User defined code block is not executed when disabled and verify fails (verify_false)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify_false that fails
  Then user defined code block won't be executed


Scenario: User defined code block is not executed when disabled and verify passes (verify_false)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify_false that passes
  Then user defined code block won't be executed


Scenario: User defined code block is executed (verify_equal)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify_equal that fails
  Then user defined code block will be executed


Scenario: User defined code block is not executed (verify_equal)
  Given I have default sut
  And I enable custom on error verify block
  And I call verify_equal that passes
  Then user defined code block won't be executed


Scenario: User defined code block is not executed when disabled and verify fails (verify_equal)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify_equal that fails
  Then user defined code block won't be executed


Scenario: User defined code block is not executed when disabled and verify passes (verify_equal)
  Given I have default sut
  And I disable custom on error verify block
  And I call verify_equal that passes
  Then user defined code block won't be executed

Scenario: User defined code block is executed (verify_signal)
  Given I have default sut
  When I launch application "calculator"
  And I enable custom on error verify block
  And I call verify_signal that fails
  Then user defined code block will be executed
  
Scenario: User defined code block is not executed (verify_signal)
  Given I have default sut
  When I launch application "calculator"
  And I enable custom on error verify block
  And I call verify_signal that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_signal)
  Given I have default sut
  When I launch application "calculator"
  And I disable custom on error verify block
  And I call verify_signal that fails
  Then user defined code block won't be executed
  
Scenario: User defined code block is not executed when disabled and verify passes (verify_signal)
  Given I have default sut
  When I launch application "calculator"
  And I disable custom on error verify block
  And I call verify_signal that passes
  Then user defined code block won't be executed
  
  

