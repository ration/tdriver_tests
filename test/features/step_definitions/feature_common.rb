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
include TDriverReportAPI

Before do

  $ErrorMessage=""

  $__sut_mem_data = Array.new if $__sut_mem_data==nil
  @__current_app = nil
  @__apps = {}
  @__ret_val = nil
  @__exception = nil
  @__example_given = false

  sut = ENV['TDRIVER_DEFAULT_SUT']
  sut = TDriver.parameter[:default_sut] if !sut or sut.empty?
  #sut = "default_sut" if !sut or sut.empty?

  @__sut = TDriver.sut(sut.to_sym) if sut != nil
  @__os_name = MobyUtil::EnvironmentHelper.platform.to_s

  @__sut.log_mem({:interval => 2, :filePath => '/tmp/'}) if RUBY_PLATFORM.downcase.include?("linux")
  @__sut.log_mem({:interval => 2, :filePath => 'C:/temp'}) if RUBY_PLATFORM.downcase.include?("mswin")
  @__sut.log_mem({:interval => 2, :filePath => 'C:/temp'}) if RUBY_PLATFORM.downcase.include?("mingw")


end

After do | scenario |

  $__sut_mem_data <<  [scenario.to_sexp[3],@__sut.state_object(@__sut.stop_mem_log)]
  
  $__sut_mem_data.each do |data|   
    log_data=data[1]   #@__sut.state_object(data[1])   
    count = log_data.logData.attribute('entryCount').to_i      
    i = 0
    if count > 0
      while i < count do
        mem=log_data.logEntry(:id => i.to_s).attribute('heapSize').to_i
        tdriver_log_data({"Scenario" => "#{data[0]}","Qttas mem usage"=> mem})
        i += 1
      end
    end
    
  end
  

  @__sut.unfreeze if @__sut.frozen

  @__apps.each_key do |app|
    begin
      @__apps[app].close if @__apps[app].name != 'qttasserver'
    rescue Exception => e
      # nothing
    end
  end

  if scenario.failed?

    close_counter=0
      if @fail_counter==nil
        @fail_counter=0
      end
      @fail_counter+1

      #Try to recover and check running apps
      app_list=@__sut.list_apps
      tdriver_report_log("Running applications: <div>#{app_list.to_s.gsub(/[<>]/,' ')}</div>")

      if @fail_counter>10
        puts "Tests failing termitating execution"
        Kernel::exit(1)
      end

  else

    @fail_counter=0

  end

  begin

  	@__sut.kill_started_processes

  rescue

  end

  @__sut.clear_verify_blocks

  #Raising exception if it hasn't been handled
  raise @__exception if @__exception != nil

end

Given /^this scenario is pending$/ do
  pending # always
end

Given /^I have default sut$/ do
  @sut = @__sut
end

Given /^I create sut object "([^\"]*)"$/ do | arg1 |
  @sut = TDriver.sut( :Id => arg1.to_s)
end

Given /^I launch application "([^\"]*)"$/ do | app_name |
  app_ref = "@app"
  raise "No default sut given! Please set env variable TDRIVER_DEFAULT_SUT!" if @__sut == nil
  @__apps[app_ref] = @__sut.run( :name => app_name.to_s , :arguments => "-testability,-style,motif")
  eval(app_ref + " = @__apps[app_ref]")
  @__current_app = @__apps[app_ref]
end


Given /^I launch application "([^\"]*)" as "([^\"]*)"$/ do | app_name, app_ref |

  raise "No default sut given! Please set env variable TDRIVER_SUT!" if @__sut == nil
  @__apps[app_ref] = @__sut.run( :name => app_name.to_s , :arguments => "-testability,-style,motif")
  eval(app_ref + " = @__apps[app_ref]")
  @__current_app = @__apps[app_ref]
end

Given /^I launch application "([^\"]*)" as "([^\"]*)" on sut "([^\"]*)"$/ do | app_name, app_ref, sut_id |

  tmp_app = TDriver.sut(sut_id.to_sym).run( :name => app_name.to_s , :arguments => "-testability,-style,motif")
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

Given "the $target_type is at absolute location $x, $y" do | object_type, x, y |

  temp_object = @__current_app.child( :type => object_type )
  temp_object.set_attribute('pos', "#{x},#{y}", 'QPoint')  
  
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

Given /^I trigger "([^\"]*)" from "([^\"]*)"$/ do | action_name, parent_name |
  @__current_app.child(:name => parent_name.to_s).QAction( :name => action_name.to_s).trigger
end

Given /^I set child "([^\"]*)" attribute "([^\"]*)" to "([^\"]*)"$/ do | name, attribute, value |
  @__current_app.child(:name => name).set_attribute(attribute, value)
end


Given /^I tap down on Triangle(\d+)$/ do | arg1 |
  @app.Triangle(:name => 'Triangle'+arg1.to_s).tap_down
end


When /^I execute "([^\"]*)"$/ do | script |
  raise 'Invalid step! In these feature tests there should be only one "When I execute..." example code per scenario.' if @__example_given
  @__example_given = true
  begin
    @__ret_val = eval(script)
  rescue Exception => e
    @__exception = e
  end
end

When "I execute" do | script |
  raise 'Invalid step! In these feature tests there should be only one "When I execute..." example code per scenario.' if @__example_given
  @__example_given = true
  begin
    @__ret_val = eval(script)
  rescue Exception => e
    @__exception = e
  end
end


When /^I test code "([^\"]*)"$/ do | script |
  begin
    @__ret_val = eval(script)
  rescue Exception => e
    @__exception = e
  end
end

When "I can delete file \"$file\"" do | file |
  verify_true(0,"The file doesn't exist"){File.exist?(file)}
  File.delete(file)
  verify_false(0,"The file still exists"){File.exist?(file)}
end

Then "I add \"$app\" to close list" do | app |
  app_ref = app
  eval("@__apps['" + app_ref + "'] = " + app)
  @__current_app = @__apps[app_ref]
end

Then "I delete file \"$file\" from sut" do | file |
  @sut.delete_from_sut(:dir => file )
end


Then /^application "([^\"]*)"(()|(?:[ ]on[ ]"([^\"]*)")*) (is|is not) running$/ do | application_name, sut_given, sut_name, sut_object_name, application_status |

  raise @__exception if @__exception != nil

  # convert application name to string
  application_name = application_name.to_s

  # use defined sut object name if given 
  if sut_given.to_s.empty?

    # not sut given, use default sut
    sut_object = @__sut

  else

    # retrieve sut object
    sut_object = eval( sut_object_name )

    # verify that given object is SUT object
    raise ArgumentError, "Given SUT object #{ sut_object_name.inspect } is type of #{ sut_object.class } (expected type: MobyBase::SUT)" unless sut_object.kind_of?( MobyBase::SUT )
    
  end

  if ((@__os_name == "linux") and RUBY_PLATFORM.downcase.include?("linux")) or 
      ((@__os_name == "windows") and RUBY_PLATFORM.downcase.include?("mswin"))or
      ((@__os_name == "windows") and RUBY_PLATFORM.downcase.include?("mingw"))or
      (@__os_name == "")

    # modify application name when running on windows env
	#why is exe added? it is not coming in the ui state
    #application_name = application_name + '.exe' if RUBY_PLATFORM.downcase.include?("mswin")

    # determine expected result, used for comparing with actual result
    expected_result = ( application_status == 'is' )

    # error message if verify fails
    error_message = expected_result ? "Application should be running" : "Application should not be running"

    # verify loop for 30 seconds
    verify_equal( expected_result, 30, error_message ){

      # negate expected result
      result = !expected_result

      begin

        # compare application names
    		#puts sut_object.application(:__timeout=>0 ).name + " <> " + application_name
		 
        result = ( sut_object.application(:__timeout=>0 ).name == application_name )

      rescue

        # do nothing, retry

      end

      # return actual result
      result

    }

  else

    warn 'This step was not tested due to OS was not detected properly'

  end

end

Then /^The calculator display says "([^\"]*)"$/ do | result |
  raise @__exception if @__exception != nil
  verify_equal(result.to_s, 10, 'Calculator displays wrong value') { @__current_app.child(:name => 'display').attribute('text').to_s }
end

Then /^object named "([^\"]*)" is visible on screen$/ do | arg1 |
  raise @__exception if @__exception != nil
  verify {@__current_app.child(:name => arg1.to_s, :visibleOnScreen => true) }
end

Then /^object named "([^\"]*)" is not visible on screen$/ do | arg1 |
  raise @__exception if @__exception != nil
  verify {@__current_app.child(:name => arg1.to_s, :visibleOnScreen => false) }
end

Then /^object named "([^\"]*)" is visible$/ do | arg1 |
  raise @__exception if @__exception != nil
  verify {@__current_app.child(:name => arg1.to_s, :visible => true) }
end

Then /^object named "([^\"]*)" is not visible$/ do | arg1 |
  raise @__exception if @__exception != nil
  verify {@__current_app.child(:name => arg1.to_s, :visible => false) }
end

Then /^object named "([^\"]*)" does not exist$/ do | arg1 |
  raise @__exception if @__exception != nil
  verify_not {@__current_app.child(:name => arg1.to_s) }
end

Then /^exception is thrown$/ do

  verify_false(0, "Exception has not been raised") { @__exception.nil? }

  # reset exception variable, otherwise exception will be actually raised!
  @__exception = nil

end


Then /^exception is not thrown$/ do
  begin
    verify_true(0, "Exception has been raised") { @__exception.nil? }
  rescue
    raise @__exception
  end
end

Then /^exception type of "([^\"]*)" is thrown$/ do | expected |

  verify_false(0, "No exception has not been raised") { @__exception.nil? }

  verify_true(0, "Thrown exception type of #{ @__exception.class } does not match with #{ expected.inspect }"){ 

    @__exception.class.to_s == expected.to_s 

  }

  @__exception=nil
end

Then /^exception matching "([^\"]*)" is thrown$/ do | arg1 |
  verify_false(0, "No exception has not been raised") { @__exception.nil? }
  re = Regexp.new(arg1.to_s)
  verify_false(0, "Exception '#{@__exception.to_s}' does not match given regexp #{re.inspect}") { (re =~ @__exception.to_s).nil? }
  #exception handled can be set to nil
  @__exception=nil
end

Then /^I set the value "([^\"]*)" to "([^\"]*)" sut parameter$/ do | arg1,arg2 |
  @sut.parameter[arg2.to_sym]=arg1
end

Then "the $target_type has moved $expected_direction" do | target_type, expected_direction |

  raise @__exception if @__exception != nil
  verify_true(30, "The #{target_type} did not move #{expected_direction}") do

    result = false
    temp_obj = @__current_app.child( :type => target_type )
    case expected_direction
    when "left"
      result = temp_obj.attribute( "x" ).to_i < @initial_x.to_i
    when "right"
      result = temp_obj.attribute( "x" ).to_i > @initial_x.to_i
    when "down"
      result = temp_obj.attribute( "y" ).to_i > @initial_y.to_i
    when "up"
      result = temp_obj.attribute( "y" ).to_i < @initial_y.to_i
    end

    result

  end

end

Then "the $target_type has not moved" do | target_type |

  raise @__exception if @__exception != nil
  verify_true(30, "The #{target_type} did move") do

    temp_obj = @__current_app.child( :type => target_type )

    ( temp_obj.attribute( "x" ).to_i == @initial_x.to_i ) and ( temp_obj.attribute( "y" ).to_i == @initial_y.to_i )

  end

end

Then "the $target_type has the $expected_attribute attribute with value $expected_value" do | target_type, expected_attribute, expected_value |

  raise @__exception if @__exception != nil
  verify_equal(expected_value, 30, "The #{target_type} did not have the #{expected_attribute} attribute with a value of #{ expected_value }") do

    temp_obj = @__current_app.child( :type => target_type )
    temp_obj.attribute( expected_attribute )

  end

end

Then /^verify "([^\"]*)"$/ do | arg1 |
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

Then "the scenepos of $obj is $pos" do | obj, pos |
  verify_equal(pos, 5){@__current_app.child( :type => obj).attribute('scenePos')}
end

Then "I set testapp to fullscreen" do
  seq = MobyCommand::KeySequence.new(:kControl, :KeyDown).append!(:kF).append!(:kControl, :KeyUp)
  @__current_app.press_key(seq)
end

Then "$target_type is on top of $target2_type" do | target_type, target_type2 |
  verify_equal(@__current_app.child( :type => target_type2).attribute('x'), 5){@__current_app.child( :type => target_type).attribute('x')}
end

Then /^I find and delete the file "([^\"]*)"$/ do | file |
  File.delete(file)
end

When("I hide the triangle") do
  @app.Triangle(:name => "Triangle1").set_attribute("visible", false)
end

When("I hide the node") do
  @app.Node(:name => "Node1").set_attribute("visible", false)
end

Then("I flick the screen $screen_object $direction") do | screen_object,  direction |
  @app.send( screen_object.to_sym ).flick( direction.to_sym )
end

Then ("I move to webkit screen") do
  @app.Triangle(:name => "Triangle1").set_attribute("visible", false)
  @app.Node(:name => "Node1").set_attribute("visible", false)
  @app.NodeView.flick(:Left)
  @app.EditView.flick(:Left)
end

Then ("I verify evaluate string \"$evaluate_string\"") do | evaluate_string |
  verify(3){eval( evaluate_string )}
end

Then /^the code "([^\"]*)" returns true$/ do |code|
  eval(code) == true
end

Then "the new absolute location of the $target_type is $expected_x, $expected_y" do | target_type, expected_x, expected_y | 

  verify_equal(expected_x.to_i, 30, "The #{target_type} was not at absolute location #{expected_x}, #{expected_y}") do
    
    temp_obj = @__current_app.child( :type => target_type )
    obj_height = temp_obj.attribute( :height ).to_i
      
    obj_height/2 + temp_obj.attribute("x_absolute").to_i	
    
  end
  
  verify_equal(expected_y.to_i, 30, "The #{target_type} was not at absolute location #{expected_x}, #{expected_y}") do
    
    temp_obj = @__current_app.child( :type => target_type )
    obj_width = temp_obj.attribute( :width ).to_i
      
    obj_width/2 + temp_obj.attribute("y_absolute").to_i	
	
  end

end

Then /^color of Triangle(\d+) is "([^"]*)"$/ do |arg1, arg2|
  raise @__exception if @__exception != nil
  verify_equal(arg2, 2, "Expeting color #{arg2}") { @app.Triangle(:name => "Triangle"+arg1.to_s).attribute('color') }
end

Then ("I verify that \"$object\" is having \"$attrib\" with value \"$value\"") do | obj, attrib, value |
  @app.send(obj.to_sym, {attrib=>value}).name
end

Then ("I verify that \"$obj\" is having \"$attrib\" with evaluated value \"$value\"") do | obj, attrib, value |
  @app.send(obj.to_sym, {attrib=>eval(value).to_s}).name
end

Given /^I sleep "([^"]*)" second$/ do |arg1|
  sleep arg1.to_i
end
