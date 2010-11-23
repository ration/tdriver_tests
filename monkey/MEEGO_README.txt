MEEGO EXAMPLE TEST MONKEYS

The three example MeeGo monkey test controllers demonstrate both standard and smart monkey testing.
They also show how to control monkey test session duration using both iterations and timeouts.
Limiting monkey testing to a single application is also included in the examples.


standard_meego_monkey.rb - Standard testing, configurable iterations

A TDMonkey controller for performing standard monkey testing. This monkey is not 
limited to any single application. The number of monkey iterations can be given 
as an optional argument. By default the monkey will be executed 10 times.

Execution examples:
ruby standard_meego_monkey.rb
ruby standard_meego_monkey.rb 5


smart_meego_monkey.rb - Smart testing, configurable target application

This TDMonkey is configured for smart monkey testing. By default, the monkey will test 
any apps that are active on the user interface. Optionally the monkey can be limited to 
testing a specific application by giving the application name as an argument, e.g. the 
widgetsgallery app is suitable for trying out the smart monkey.

Execution examples:
ruby smart_meego_monkey.rb
ruby smart_meego_monkey.rb widgetsgallery


hybrid_meego_monkey.rb - Both standard and smart testing, configurable execution duration

The third monkey controller performs both smart and standard monkey testing on any app 
that is active on the target user interface. Monkey testing continues until a timeout 
is reached. The default timeout is 10 minutes and can be overwritten when the monkey controller
is called.

Execution examples:
ruby hybrid_meego_monkey.rb
ruby hybrid_meego_monkey.rb 2


meego_monkey_configuration.rb
This file contains a TDMokey configuration suitable for use with MeeGo test targets. All these 
monkey test example controllers use this TDMonkey configuration.
