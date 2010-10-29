############################################################################
##
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
## All rights reserved.
## Contact: Nokia Corporation (testabilitydriver@nokia.com)
##
## This file is part of TDriver.
##
## If you have questions regarding the use of this file, please contact
## Nokia at testabilitydriver@nokia.com .
##
## This library is free software; you can redistribute it and/or
## modify it under the terms of the GNU Lesser General Public
## License version 2.1 as published by the Free Software Foundation
## and appearing in the file LICENSE.LGPL included in the packaging
## of this file.
##
############################################################################


# Common step definitions to be used in feature testing of TDriver
# Author: Petri Kiiskinen
# Date: 05.10.2010
# Purpose: Common steps to be used in feature testing


require 'tdriver'
include TDriverVerify

Before do
        $ErrorMessage=""
    @__current_app = nil
    @__apps = {}
    @__ret_val = nil
    @__exception = nil
    @__example_given = false
    sut = ENV['TDRIVER_DEFAULT_SUT']
    sut = TDriver.parameter[:default_sut] if !sut or sut.empty?
    #sut = "default_sut" if !sut or sut.empty?
    @__sut = TDriver.sut(sut.to_sym) if sut != nil
end

After do

    @__apps.each_key do |app|

        begin
            @__apps[app].kill
        rescue Exception => e
            # nothing
        end
    end
end


Given /^I have default sut$/ do
  @sut = @__sut
end

Given /^I create sut object "([^\"]*)"$/ do |arg1|
  @sut = TDriver.sut( :Id => arg1.to_s)
end

Given /^I launch application "([^\"]*)"$/ do |app_name|

    app_ref = "@app"
    raise "No default sut given! Please set env variable TDRIVER_DEFAULT_SUT!" if @__sut == nil
    @__apps[app_ref] = @__sut.run( :name => app_name.to_s )
    eval(app_ref + " = @__apps[app_ref]")
    @__current_app = @__apps[app_ref]
end


Given /^I launch application "([^\"]*)" as "([^\"]*)"$/ do |app_name, app_ref|

    raise "No default sut given! Please set env variable TDRIVER_SUT!" if @__sut == nil
    @__apps[app_ref] = @__sut.run( :name => app_name.to_s )
    eval(app_ref + " = @__apps[app_ref]")
    @__current_app = @__apps[app_ref]
end

Given /^I launch application "([^\"]*)" as "([^\"]*)" on sut "([^\"]*)"$/ do |app_name, app_ref, sut_id|

    tmp_app = TDriver.sut(sut_id.to_sym).run( :name => app_name.to_s )
    eval(app_ref + " = tmp_app")
    @__apps[app_ref] = tmp_app
    @__current_app = @__apps[app_ref]
end

Given /^I show FloatingMenu of the testapp$/ do
  @__current_app.ControlTab( :name => 'ControlTab').drag(:Up, 10)
end


Given "I know the $target_type initial location" do | target_type |

  temp_obj = @__current_app.child( :type => target_type )

  @initial_x = temp_obj.attribute( "x" )
  @initial_y = temp_obj.attribute( "y" )

end

Given "the $target_type is at location $x, $y" do | object_type, x, y |

  temp_object = @__current_app.child( :type => object_type )
  temp_object.set_attribute("x", x)
  temp_object.set_attribute("y", y)
end


Given "I $method $object_type named \"$object_name\"" do | method, object_type, object_name |

  eval "@app.#{object_type}( :name => '#{object_name}' ).#{method}"
end

Given "there is only $article $target_type on the testapp screen" do | article, target_type |

  @__current_app.ControlTab( :name => 'ControlTab').drag(:Up, 10)

  @__current_app.Control( :name => "Reset" ).tap
  case target_type
    when "Node"
          @__current_app.Control( :name => "AddNode" ).tap
        when "Rectangle"
          @__current_app.Control( :name => "AddRectangle" ).tap
  end

  temp_obj = @__current_app.child( :type => target_type )

  @initial_x = temp_obj.attribute( "x" )
  @initial_y = temp_obj.attribute( "y" )

  @__current_app.ControlTab( :name => 'ControlTab').drag(:Down, 10)

end

Given "the $target_type is assigned to the $new_object object" do | target_type, new_object |

  eval("#{new_object} = @__current_app.child( :type => '#{target_type}' )")

end

Given /^I trigger "([^\"]*)" from "([^\"]*)"$/ do |action_name, parent_name|
  @__current_app.child(:name => parent_name.to_s).QAction( :name => action_name.to_s).trigger
end

Given /^I set child "([^\"]*)" attribute "([^\"]*)" to "([^\"]*)"$/ do |name, attribute, value|
  @__current_app.child(:name => name).set_attribute(attribute, value)
end

When /^I execute "([^\"]*)"$/ do |script|
    raise 'Invalid step! In these feature tests there should be only one "When I execute..." example code per scenario.' if @__example_given
    @__example_given = true
    begin
        @__ret_val = eval(script)
    rescue Exception => e
        @__exception = e
    end
end

When "I execute" do |script|
    raise 'Invalid step! In these feature tests there should be only one "When I execute..." example code per scenario.' if @__example_given
    @__example_given = true
    begin
        @__ret_val = eval(script)
    rescue Exception => e
        @__exception = e
    end
end


When /^I test code "([^\"]*)"$/ do |script|
    begin
        @__ret_val = eval(script)
    rescue Exception => e
        @__exception = e
    end
end

When "I can delete file \"$file\"" do |file|
  verify_true(0,"The file doesn't exist"){File.exist?(file)}
  File.delete(file)
  verify_false(0,"The file doesn't exist"){File.exist?(file)}
end

Then /^application "([^\"]*)" is running$/ do |arg1|
  raise @__exception if @__exception != nil
  if ((@os_name == "linux") and RUBY_PLATFORM.downcase.include?("linux")) or
    ((@os_name == "windows") and RUBY_PLATFORM.downcase.include?("mswin")) or
    (@os_name == "")
    if RUBY_PLATFORM.downcase.include?("mswin")
      verify_equal(arg1 + '.exe', 30, "Application name should match."){
        @app.executable_name
      }
    else
      verify_equal(arg1.to_s, 30, "Application name should match."){
        @app.executable_name
      }
    end
  end
end


Then /^application "([^\"]*)" is not running$/ do |arg1|
  raise @__exception if @__exception != nil
  if ((@os_name == "linux") and RUBY_PLATFORM.downcase.include?("linux")) or
    ((@os_name == "windows") and RUBY_PLATFORM.downcase.include?("mswin")) or
    (@os_name == "")
    if RUBY_PLATFORM.downcase.include?("mswin")
      verify_false(30, 'application should not be running') {
        @sut.application.name == arg1 + '.exe'
      }
    else
      verify_false(30, 'application should not be running') {
        @sut.application.name == arg1
      }
    end
  end
end

Then /^The calculator display says "([^\"]*)"$/ do |result|
    raise @__exception if @__exception != nil
    verify_equal(result.to_s, 10, 'Calculator displays wrong value') { @__current_app.child(:name => 'display').attribute('text').to_s }
end

Then /^object named "([^\"]*)" is visible on screen$/ do |arg1|
  raise @__exception if @__exception != nil
  verify {@__current_app.child(:name => arg1.to_s, :visibleOnScreen => true) }
end

Then /^object named "([^\"]*)" is not visible on screen$/ do |arg1|
  raise @__exception if @__exception != nil
  verify {@__current_app.child(:name => arg1.to_s, :visibleOnScreen => false) }
end

Then /^object named "([^\"]*)" is visible$/ do |arg1|
  raise @__exception if @__exception != nil
  verify {@__current_app.child(:name => arg1.to_s, :visible => true) }
end

Then /^object named "([^\"]*)" is not visible$/ do |arg1|
  raise @__exception if @__exception != nil
  verify {@__current_app.child(:name => arg1.to_s, :visible => false) }
end

Then /^exception is thrown$/ do
  verify_false(0, "Exception has not been raised") { @__exception.nil? }
end


Then /^exception is not thrown$/ do
  begin
    verify_true(0, "Exception has been raised") { @__exception.nil? }
  rescue
    raise @__exception
  end
end

Then /^exception matching "([^\"]*)" is thrown$/ do |arg1|
  verify_false(0, "No exception has not been raised") { @__exception.nil? }
  re = Regexp.new(arg1.to_s)
  verify_false(0, "Exception '#{@__exception.to_s}' does not match given regexp #{re.inspect}") { (re =~ @__exception.to_s).nil? }
end

Then "the $target_type has moved $expected_direction" do | target_type, expected_direction |

  raise @__exception if @__exception != nil
  verify_true(30, "The #{target_type} did not move #{expected_direction}") do

        result = false
        temp_obj = @__current_app.child( :type => target_type )
    case expected_direction
      when "left"
            result = temp_obj.attribute( "x" ) < @initial_x
          when "right"
            result = temp_obj.attribute( "x" ) > @initial_x
      when "down"
            result = temp_obj.attribute( "y" ) > @initial_y
          when "up"
            result = temp_obj.attribute( "y" ) < @initial_y
    end

        result

  end

end

Then "the $target_type has not moved" do | target_type |

  raise @__exception if @__exception != nil
  verify_true(30, "The #{target_type} did move") do

        temp_obj = @__current_app.child( :type => target_type )

        ( temp_obj.attribute( "x" ) == @initial_x ) and ( temp_obj.attribute( "y" ) == @initial_y )

  end

end

Then "the $target_type has the $expected_attribute attribute with value $expected_value" do | target_type, expected_attribute, expected_value |

  raise @__exception if @__exception != nil
  verify_equal(expected_value, 30, "The #{target_type} did not have the #{expected_attribute} attribute with a value of #{ expected_value }") do

        temp_obj = @__current_app.child( :type => target_type )
        temp_obj.attribute( expected_attribute )

  end

end

Then /^verify "([^\"]*)"$/ do |arg1|
  raise @__exception if @__exception != nil
  verify_true(1, "statement '#{arg1.to_s}' should evaluate to true" ) { eval(arg1.to_s) }

end


Then "the $target_type with $id_type $id_value has the attribute $expected_attribute with the value $expected_value" do | target_type, target_attribute, target_value, expected_attribute, expected_value |

  raise @__exception if @__exception != nil
  verify_equal(expected_value, 30, "The #{target_type} did not have the #{expected_attribute} attribute with a value of #{ expected_value }") do

        result = false
        temp_obj = @__current_app.child( :type => target_type, target_attribute.to_sym => target_value )

        temp_obj.attribute( expected_attribute )

  end


end

Then "the new location of the $target_type is $expected_x, $expected_y" do | target_type, expected_x, expected_y |

  raise @__exception if @__exception != nil
  verify(30, "The #{target_type} was not at location #{expected_x}, #{expected_y}") do

        temp_obj = @__current_app.child( :type => target_type, :x => expected_x, :y => expected_y )

  end

end

Then /^I find and delete the file "([^\"]*)"$/ do |file|
  File.delete(file)
end

When("I hide the triangle") do
  @app.Triangle(:name => "Triangle1").set_attribute("visible", false)
end

When("I hide the node") do
  @app.Node(:name => "Node1").set_attribute("visible", false)
end

Then("I flick the screen $screen_object $direction") do |$screen_object, $direction|
  @app.send($screen_object.to_sym).flick($direction.to_sym)
end

Then ("I move to webkit screen") do
  @app.Triangle(:name => "Triangle1").set_attribute("visible", false)
  @app.Node(:name => "Node1").set_attribute("visible", false)
  @app.NodeView.flick(:Left)
  @app.EditView.flick(:Left)
end

Then ("I verify evaluate string \"$evaluate_string\"") do |$evaluate_string|
  verify(3){eval($evaluate_string)}
end

Then /^the code "([^\"]*)" returns true$/ do |code|
  eval(code) == true
end
