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


# The test application must be in path for this to work.
require 'tdriver'
#require File.join( File.expand_path( ENV['TDRIVER_HOME'] ), 'tdriver.rb' )
#require File.join( File.dirname( __FILE__ ), '../../../../tdriver/lib/tdriver.rb' )

require 'spec/expectations'
include TDriverVerify

And("debugger") do
  debugger
end

Given("the \"$testapp\" is running") do |testapp|
  @sut.run(:name => 'testapp')  
  verify{@test_app = @sut.application(:name => 'testapp')}
end

Given("menu activated") do
  @test_app.Menu.ControlTab(:name => 'ControlTab').flick(:Up) 
  verify_true(60, 'menu active') {  @test_app.Menu(:name => 'FloatingMenu').attribute('isActive') == 'true' }  
end

When("I tap \"$text\" button") do |text|
  @node_count = @test_app.NodeView(:name => 'NodeArea').attribute('nodeCount').to_i
  @test_app.Menu.Control(:text => text).tap
end

When("I deactivate menu") do 
  @test_app.Menu.ControlTab(:name => 'ControlTab').flick(:Down) 
  verify_true(60, 'menu not active') {  @test_app.Menu(:name => 'FloatingMenu').attribute('isActive') == 'false' }  
end

When("I check that $number node exists") do |number|
  verify_equal(number.to_i){@test_app.NodeView(:name => 'NodeArea').attribute('nodeCount').to_i}
  @node_count = @test_app.NodeView(:name => 'NodeArea').attribute('nodeCount').to_i 
  @nodeid = "Node"+@node_count.to_s
  @node = @test_app.Node(:name => @nodeid)
end

When("I tap_down the node") do
   @node.tap_down
end

When("I tap_down the triangle") do
   @test_app.Triangle.tap_down
end

When("I tap down the rectangle") do
  @test_app.Rectangle.tap_down
end

When("I check that one rectangle exists") do
  count = @test_app.NodeView(:name => 'NodeArea').attribute('rectangleCount').to_i
  if count == 0	
	@test_app.Menu.ControlTab(:name => 'ControlTab').flick(:Up) 
	@test_app.Menu.Control(:text => 'Rectangle').tap
	@test_app.Menu.ControlTab(:name => 'ControlTab').flick(:Down) 
  end
  @rectange = @test_app.Rectangle
end

When("I drag the node") do
  window_width = @test_app.NodeView.attribute('width').to_i
  @x = @node.attribute('x').to_i
  @direction = :Right
  @direction = :Left if (@x + 200) > window_width
  @node.drag(@direction, 100)
end

When("I drag the rectangle") do
  window_width = @test_app.NodeView.attribute('width').to_i
  @x = @rectange.attribute('x').to_i
  @direction = :Right
  @direction = :Left if (@x + 200) > window_width
  @rectange.drag(@direction, 100)
  @drag_target = @test_app.Rectangle
end

When("I flick the node") do
  window_width = @test_app.NodeView.attribute('width').to_i
  @x = @node.attribute('x').to_i
  @direction = :Right
  @direction = :Left if (@x + 200) > window_width
  @node.flick(@direction)
  @flick_target = @test_app.Node(:name => @nodeid)  
end

When("I drag the node to top of rectangle") do
  rectangle = @test_app.Rectangle(:name => 'Rectangle1')
  @node.drag_to_object(rectangle)
  @node = @test_app.Node(:name => @nodeid)
end

When("I gesture the node to top of rectangle") do
  rectangle = @test_app.Rectangle(:name => 'Rectangle1')
  @node.gesture_to_object(rectangle, 1)
  @node = @test_app.Node(:name => @nodeid)
end

When("I add $amount nodes") do |amount|
  @test_app.Menu.Control(:text => 'Node').tap(amount)
  @node_has = Hash.new
  id = 1
  while id < amount.to_i do
	node = @test_app.Node(:name => 'Node'+id.to_s) 
	@node_has[node.id] = node.attribute('x') + ',' + node.attribute('y')
	id = id+1
  end
end

When("I add $amount rectangles") do |amount|
  @test_app.Menu.Control(:text => 'Rectangle').tap(amount)
  @rectangle_has = Hash.new
  id = 1
  while id < amount.to_i do
	rectangle = @test_app.Rectangle(:name => 'Rectangle'+id.to_s)             
	@rectangle_has[rectangle.id] = rectangle.attribute('x') + ',' + rectangle.attribute('y')
	id = id+1
  end
end

Then("it should change fill color of rectangle from \"$old_color\" to \"$new_color\"") do |old_color, new_color|
  verify_equal(new_color, 5){@test_app.Rectangle.attribute('color')}
  @test_app.Rectangle.tap_up
  verify_equal(old_color, 5){@test_app.Rectangle.attribute('color')}
end

Then("it should create new \"$color\" node to random location in test application") do |color|
  new_node_count = @test_app.NodeView(:name => 'NodeArea').attribute('nodeCount').to_i
  new_node_count.should > @node_count
  nodeid = "Node"+@node_count.to_s
  node = @test_app.Node(:name => nodeid)
  verify_equal(color, 5){node.attribute('color')}
end

Then("it should create new \"$color\" rectangle to random location in test application") do |color|
  rectangle = @test_app.Rectangle(:name => 'Rectangle1')
  rectangle.attribute('color').should == color
end

Then("it should change color of node from \"$color\" to \"$new_color\"") do |color, new_color|
  verify_equal(new_color, 5){@test_app.Node(:name => @nodeid).attribute('color')}
  @test_app.Node(:name => @nodeid).tap_up
  verify_equal(color, 5){@test_app.Node(:name => @nodeid).attribute('color')}
end

Then("it should change color of triangle from \"$color\" to \"$new_color\"") do |color, new_color|
  verify_equal(new_color, 5){@test_app.Triangle.attribute('color')}
  @test_app.Triangle.tap_up
  verify_equal(color, 5){@test_app.Triangle.attribute('color')}
end

Then("node should change position according the given drag") do
  if @direction == :Right
	verify_equal(@x + 100, 5){@test_app.Node(:name => @nodeid).attribute('x').to_i}
  else
	verify_equal(@x - 100, 5){@test_app.Node(:name => @nodeid).attribute('x').to_i}
  end
end

Then("rectangle should change position according the given drag") do
  if @direction == :Right
	verify_equal(@x + 100, 5){@test_app.Rectangle.attribute('x').to_i}
  else
	verify_equal(@x - 100, 5){@test_app.Rectangle.attribute('x').to_i}
  end
end

Then("its name should be \"$name\"") do |name|
  verify{@test_app.Node(:name => name)}
end

Then("rectangles name should be \"$name\"") do |name|
  verify{@test_app.Rectangle(:name => name)}
end

Then("rectangle should change fill color to \"$new_color\"") do |new_color|
  verify_equal(new_color, 5){@test_app.Rectangle(:name => 'Rectangle1').attribute('color')}
end

Then ("the view should have $amount of nodes and rectangles") do |amount|
  @test_app.NodeView(:name => 'NodeArea').attribute('nodeCount').to_i.should == amount.to_i
  @test_app.NodeView(:name => 'NodeArea').attribute('rectangleCount').to_i.should == amount.to_i
end


Then("it should move all nodes and rectangles to new random locations") do
  @node_has.each_key do |key|
	node = @test_app.Node(:id => key)
	coords = node.attribute('x') + ',' + node.attribute('y')
	@node_has[key].should_not == coords
  end 

  @rectangle_has.each_key do |key|
	rectangle = @test_app.Rectangle(:id => key)
	coords = rectangle.attribute('x') + ',' + rectangle.attribute('y')
	@rectangle_has[key].should_not == coords
  end 
end

Then("it should change position") do
  @flick_target.attribute('x').should_not == @x
end
