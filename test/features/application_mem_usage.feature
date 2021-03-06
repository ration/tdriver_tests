@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::Application#mem_usage
  As a test scripter writer
  I want to use mem_usage method to get the memory consumption of the application
  so that I can test the MobyBehaviour::Application behaviour

  Scenario: Get application memory usage
    Given I launch application "calculator" as "@app"
    When I execute "@app.mem_usage"
    Then exception is not thrown

  @nodoc
  Scenario: Application memory usage is type of Integer
    Given I launch application "calculator" as "@app"
    When I execute "@mem = @app.mem_usage"
    And exception is not thrown
    Then verify "@mem.kind_of?( Integer )" 

