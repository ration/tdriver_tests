@qt_linux @qt_windows @qt_symbian @qt_meego

Feature: MobyBehaviour::TestObject#creation_attributes=
  As a test scripter writer
  I want to use creation_attributes attribute to retrieve the attributes used to create a Test Object
  so that I can test the MobyBehaviour::TestObject behaviour

  Scenario: Testing creation_attributes accessor method
    Given I launch application "testapp" as "@app"
    When I execute "$attributes_hash=@app.Triangle( :name => 'Triangle1' ).creation_attributes"
    Then the contents of "$attributes_hash" should be equal to "{ :name => 'Triangle1', :type => :Triangle }"

  Scenario: Testing creation_attributes accessor method to set new creation attributes
    Given I launch application "testapp" as "@app"
    And I change the creation attributes for Test Object "$triangle" to "{ :x => '600' }"
    When I execute "$attributes_hash=$triangle.creation_attributes"
    Then the contents of "$attributes_hash" should be equal to "{ :x => '600' }"

  Scenario: Testing creation_attributes accessor method are unchanged when two instances of the same Test Object are retrieved
    Given I launch application "testapp" as "@app"
    When I execute "$triangle1=@app.Triangle( :name => 'Triangle1' )"
    And I retrieve another instance of Test Object "$triangle1" called "$triangle2" using child behaviour with attributes "{ :x => '430', :y => '238' }"
    Then the contents of "$triangle2.creation_attributes" should be equal to "{ :x => '430', :y => '238' }"






