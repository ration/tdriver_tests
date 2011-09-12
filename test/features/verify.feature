@qt_linux @qt_windows @qt_symbian @qt_meego
Feature: TDriver verify
	As a TDriver script developer
	I want to be able to specify verify timeouts
	so that I can write reliable tests

#verify
Scenario: User defined error message is shown with verify
  Given I have default sut
  When I call verify with with custom error message
  Then given message is in exception details

Scenario: Specify verify timeout as 0
  Given I have default sut
  When I call verify with timeout 0
  Then the verify should timeout in 0

Scenario: Specify verify timeout as 1
  Given I have default sut
  When I call verify with timeout 1
  Then the verify should timeout in 1

Scenario: Specify verify timeout as nil
  Given I have default sut
  And I set default sychronization timeout to 3
  When I call verify with no timeout value
  Then the verify should timeout with default synchronization value
  Then restore to default sychronization timeout value

Scenario: User defined code block is executed (verify)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify that fails
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify passes (verify)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify that passes
  Then user defined code block won't be executed

#verify_not
Scenario: User defined error message is shown with verify_not
  Given I have default sut
  When I call verify_not with with custom error message
  Then given message is in exception details

Scenario: Specify verify_not timeout as 0
  Given I have default sut
  When I call verify_not with timeout 0
  Then the verify should timeout in 0

Scenario: Specify verify_not timeout as 1
  Given I have default sut
  When I call verify_not with timeout 1
  Then the verify should timeout in 1

Scenario: Specify verify_not timeout as nil
  Given I have default sut
  And I set default sychronization timeout to 3
  When I call verify_not with no timeout value
  Then the verify should timeout with default synchronization value
  Then restore to default sychronization timeout value

Scenario: User defined code block is executed (verify_not)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_not that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify_not)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_not that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_not)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_not that fails
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify passes (verify_not)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_not that passes
  Then user defined code block won't be executed

#verify_true
Scenario: User defined error message is shown with verify_true
  Given I have default sut
  When I call verify_true with with custom error message
  Then given message is in exception details

Scenario: Specify verify_true timeout as 0
  Given I have default sut
  When I call verify_true with timeout 0
  Then the verify should timeout in 0

Scenario: Specify verify_true timeout as 1
  Given I have default sut
  When I call verify_true with timeout 1
  Then the verify should timeout in 1

Scenario: Specify verify_true timeout as nil
  Given I have default sut
  And I set default sychronization timeout to 3
  When I call verify_true with no timeout value
  Then the verify should timeout with default synchronization value
  Then restore to default sychronization timeout value

Scenario: User defined code block is executed (verify_true)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_true that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify_true)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_true that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_true)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_true that fails
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify passes (verify_true)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_true that passes
  Then user defined code block won't be executed

#verify_false
Scenario: User defined error message is shown with verify_false
  Given I have default sut
  When I call verify_false with with custom error message
  Then given message is in exception details

Scenario: Specify verify_false timeout as 0
  Given I have default sut
  When I call verify_false with timeout 0
  Then the verify should timeout in 0
  
Scenario: Specify verify_false timeout as 1
  Given I have default sut
  When I call verify_false with timeout 1
  Then the verify should timeout in 1

Scenario: Specify verify_false timeout as nil
  Given I have default sut
  And I set default sychronization timeout to 3
  When I call verify_false with no timeout value
  Then the verify should timeout with default synchronization value
  Then restore to default sychronization timeout value

Scenario: User defined code block is executed (verify_false)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_false that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify_false)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_false that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_false)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_false that fails
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify passes (verify_false)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_false that passes
  Then user defined code block won't be executed

#verify_equal
Scenario: User defined error message is shown with verify_equal
  Given I have default sut
  When I call verify_equal with with custom error message
  Then given message is in exception details

Scenario: Specify verify_equal timeout as 0
  Given I have default sut
  When I call verify_equal with timeout 0
  Then the verify should timeout in 0
  
Scenario: Specify verify_equal timeout as 1
  Given I have default sut
  When I call verify_equal with timeout 1
  Then the verify should timeout in 1

Scenario: Specify verify_equal timeout as nil
  Given I have default sut
  And I set default sychronization timeout to 3
  When I call verify_equal with no timeout value
  Then the verify should timeout with default synchronization value
  Then restore to default sychronization timeout value

Scenario: User defined code block is executed (verify_equal)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_equal that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify_equal)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_equal that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_equal)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_equal that fails
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify passes (verify_equal)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_equal that passes
  Then user defined code block won't be executed

#verify_less
Scenario: User defined error message is shown with verify_less
  Given I have default sut
  When I call verify_less with with custom error message
  Then given message is in exception details

Scenario: Specify verify_less timeout as 0
  Given I have default sut
  When I call verify_less with timeout 0
  Then the verify should timeout in 0
  
Scenario: Specify verify_less timeout as 1
  Given I have default sut
  When I call verify_less with timeout 1
  Then the verify should timeout in 1

Scenario: Specify verify_less timeout as nil
  Given I have default sut
  And I set default sychronization timeout to 3
  When I call verify_less with no timeout value
  Then the verify should timeout with default synchronization value
  Then restore to default sychronization timeout value

Scenario: User defined code block is executed (verify_less)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_less that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify_less)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_less that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_less)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_less that fails
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify passes (verify_less)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_less that passes
  Then user defined code block won't be executed

#verify_greater
Scenario: User defined error message is shown with verify_greater
  Given I have default sut
  When I call verify_greater with with custom error message
  Then given message is in exception details

Scenario: Specify verify_greater timeout as 0
  Given I have default sut
  When I call verify_greater with timeout 0
  Then the verify should timeout in 0
  
Scenario: Specify verify_greater timeout as 1
  Given I have default sut
  When I call verify_greater with timeout 1
  Then the verify should timeout in 1

Scenario: Specify verify_greater timeout as nil
  Given I have default sut
  And I set default sychronization timeout to 3
  When I call verify_greater with no timeout value
  Then the verify should timeout with default synchronization value
  Then restore to default sychronization timeout value

Scenario: User defined code block is executed (verify_greater)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_greater that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify_greater)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_greater that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_greater)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_greater that fails
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify passes (verify_greater)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_greater that passes
  Then user defined code block won't be executed

#verify_regexp
Scenario: User defined error message is shown with verify_regexp
  Given I have default sut
  When I call verify_regexp with with custom error message
  Then given message is in exception details

Scenario: Specify verify_regexp timeout as 0
  Given I have default sut
  When I call verify_regexp with timeout 0
  Then the verify should timeout in 0

Scenario: Specify verify_regexp timeout as 1
  Given I have default sut
  When I call verify_regexp with timeout 1
  Then the verify should timeout in 1

Scenario: Specify verify_regexp timeout as nil
  Given I have default sut
  And I set default sychronization timeout to 3
  When I call verify_regexp with no timeout value
  Then the verify should timeout with default synchronization value
  Then restore to default sychronization timeout value

Scenario: User defined code block is executed (verify_regexp)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_regexp that fails
  Then user defined code block will be executed

Scenario: User defined code block is not executed (verify_regexp)
  Given I have default sut
  And I enable on_error_verify block
  And I call verify_regexp that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_regexp)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_regexp that fails
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify passes (verify_regexp)
  Given I have default sut
  And I disable on_error_verify block
  And I call verify_regexp that passes
  Then user defined code block won't be executed

#verify_signal
Scenario: User defined error message is shown with verify_signal
  Given I have default sut
  When I launch application "calculator"
  And I call verify_signal with with custom error message
  Then given message is in exception details

Scenario: Specify verify_signal timeout as 0
  Given I have default sut
  When I launch application "calculator"
  When I call verify_signal with timeout 0
  Then the verify should timeout in 0

Scenario: Specify verify_signal timeout as 3
  Given I have default sut
  When I launch application "calculator"
  When I call verify_signal with timeout 3
  Then the verify should timeout in 3

  Scenario: Specify verify_signal with no message
  Given I have default sut
  When I launch application "calculator"
  Then I call verify_signal to catch signal clicked() with no message   

#Scenario: Specify verify_signal with message
#  Given I have default sut
#  When I launch application "calculator"
#  Then I call verify_signal to catch signal clicked() with message "The zero button should be clicked"    

Scenario: User defined code block is executed (verify_signal)
  Given I have default sut
  When I launch application "calculator"
  And I enable on_error_verify block
  And I call verify_signal that fails
  Then user defined code block will be executed
  
Scenario: User defined code block is not executed (verify_signal)
  Given I have default sut
  When I launch application "calculator"
  And I enable on_error_verify block
  And I call verify_signal that passes
  Then user defined code block won't be executed

Scenario: User defined code block is not executed when disabled and verify fails (verify_signal)
  Given I have default sut
  When I launch application "calculator"
  And I disable on_error_verify block
  And I call verify_signal that fails
  Then user defined code block won't be executed
  
Scenario: User defined code block is not executed when disabled and verify passes (verify_signal)
  Given I have default sut
  When I launch application "calculator"
  And I disable on_error_verify block
  And I call verify_signal that passes
  Then user defined code block won't be executed

