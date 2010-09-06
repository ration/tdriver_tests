############################################################################
## 
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
## All rights reserved. 
## Contact: Nokia Corporation (testabilitydriver@nokia.com) 
## 
## This file is part of MATTI. 
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


# The testapp application example must be compiled and in PATH for this example to work

require 'tdriver'
require 'test/unit'


begin
  include TDriverReport
  create_test_unit_formatter()
end
module Test #:nodoc:all
  module Unit
    module UI
      module Console
        class TestRunner
          def create_mediator(suite)
            # swap in MATTI custom mediator
            return TDriverReport::TestUnit.new(suite)
          end
        end
      end
    end
  end
end


class TC_Testapp < Test::Unit::TestCase

  TIMEOUT = 10

  # setup and teardown methods are always executed before each and after each test case method
  def setup
    # get the calculator app running
    @sut = TDriver.sut(:Id => "sut_qt")
    @tapp = @sut.run(:name => "testapp")
#    puts "PWD:" << Dir.pwd
  end

  def teardown
#    if @test_passed == false
#        puts `ps -A`
#        puts `cat /var/log/syslog`
#    end
    @tapp.close
  end

  def test_add_node
    @tapp.ControlTab.drag(:Up, 100)
    @tapp.Control( :name => 'AddNode' ).tap
    @tapp.ControlTab.drag(:Down, 100)
    
    verify(TIMEOUT, "No node added") {
      @tapp.Node( :name => 'Node2' )
    }
  end

  def test_drag_triangle
    @tapp.Node( :name => 'Node1' ).set_attribute("visible", false)
    x = @tapp.Triangle( :name => 'Triangle1' ).attribute("x").to_i
    if (x < 100)
      @tapp.Triangle( :name => 'Triangle1' ).drag(:Right,100)
    else
      @tapp.Triangle( :name => 'Triangle1' ).drag(:Left,100)
    end

    verify_true(TIMEOUT, "Triangle did not move 100") {
      (@tapp.Triangle( :name => 'Triangle1' ).attribute("x").to_i - x).abs == 100
    }
  end

  def test_flick
    @tapp.Node( :name => 'Node1' ).set_attribute("visible", false)
    @tapp.Triangle( :name => 'Triangle1' ).set_attribute("visible", false)
    @tapp.NodeView.flick(:Left)
    verify_true(TIMEOUT, "EditView not visible") {
      @tapp.EditView.attribute("visibleOnScreen") == "true"
    }
  end

  def test_screen_shot
    
    fname = File.expand_path('~/test_screen_shot.png').to_s # write to home as /tmp was too small

    if MobyUtil::EnvironmentHelper.ruby_platform =~ /mswin/
        fname = "test_screen_shot.png"
    end

    if File.exists? fname 
      File.delete(fname)
    end
    @tapp.capture_screen("PNG",fname);
    verify_true(10, "Screen capture failed") {
      File.exists? fname
    }
    File.delete(fname)
  end

  def test_move_item
    @tapp.Node( :name => 'Node1' ).set_attribute("visible", false)
    y = @tapp.Triangle( :name => 'Triangle1' ).attribute("y").to_i
    @tapp.Triangle( :name => 'Triangle1' ).tap_down
    if (y < 100)
      @tapp.Triangle( :name => 'Triangle1' ).move(:Down,100)
    else
      @tapp.Triangle( :name => 'Triangle1' ).move(:Up,100)
    end
    @tapp.Triangle( :name => 'Triangle1' ).tap_up

    verify_equal(100, TIMEOUT, "Triangle did not move 100") {
      (@tapp.Triangle( :name => 'Triangle1' ).attribute("y").to_i - y).abs
    }    
  end

  # Cause a drag operation on the screen for an object to a certain point.
  def test_drag_to  
    @tapp.Node( :name => 'Node1' ).set_attribute("visible", false)
    window_x = @tapp.NodeView.attribute('x_absolute').to_i 
    window_y = @tapp.NodeView.attribute('y_absolute').to_i
    
    @tapp.Triangle(:name =>'Triangle1').drag_to(window_x.to_i, window_y.to_i)
    
    verify_true(TIMEOUT, "Triangle was not moved to top left corner of screen"){
        @tapp.Triangle( :name => 'Triangle1' ).attribute("y").to_i < 5
    }
    verify_true(TIMEOUT,"Triangle was not moved to top left corner of screen"){
       @tapp.Triangle( :name => 'Triangle1' ).attribute("x").to_i < 5 
    }
  end
  
  def test_drag_to_object
    @tapp.Triangle( :name => 'Triangle1' ).set_attribute("visible", false)
    node= @tapp.Node(:name =>'Node1')
  
    count = @tapp.NodeView(:name => 'NodeArea').attribute('rectangleCount').to_i
    if count == 0	
      @tapp.ControlTab(:name => 'ControlTab').flick(:Up) 
      @tapp. Control( :name => 'AddRectangle' ).tap
      @tapp.ControlTab(:name => 'ControlTab').flick(:Down) 
    end
    
    rectangle = @tapp.Rectangle(:name => 'Rectangle1')
    old_color = rectangle.attribute('color')
    node.drag_to_object(rectangle)
    @tapp.Rectangle.tap_up
    new_color = rectangle.attribute('color')

    #then color of rectangle should change frm red to  blue
    verify_true(TIMEOUT, "Node was not moved over Rectangle"){
        new_color=='blue' #old_color=='red' &&  new_color=='blue'
    }
  end

  def test_find_on_screen
    fname = "quitbutton2.png"
    x=""
    y=""
    
    if File.exists? fname 
      File.delete(fname)
    end
    
    @quit = @tapp.NodeView.Control(:name =>'Quit')
    @quit.capture_screen("PNG", fname)
    
    verify_true(TIMEOUT,"Image was not created"){
      File::exists? fname
    }

    quit_button_coordinates = @tapp.find_on_screen(fname, 10 )
    #puts quit_button_coordinates.to_s
    x=quit_button_coordinates[0,1]
    y=quit_button_coordinates[1,1]
    bitmapfound='false'

    if x != "" && y != ""
      bitmapfound='true'
    end
    
    verify_true(TIMEOUT,"Image was not found on screen"){
      bitmapfound=='true'
    }
    
    #File.delete(fname)
  end

  def test_screen_contains
    fname = "quitbutton3.png"
    if File.exists? fname 
      File.delete(fname)
    end
    
    @quit = @tapp.NodeView.Control(:name =>'Quit')
    @quit.capture_screen("PNG", fname)
    
    verify_true(TIMEOUT,"Image was not created"){
      File::exists? fname
    }
    
    verify_true(TIMEOUT,"Image was not found on screen"){
      @tapp.screen_contains?(fname, 10 )
    }

    #File.delete(fname)    
  end

  def test_move_mouse
    @tapp.NodeView.Control(:name =>'Quit').move_mouse
    @tapp.Triangle(:name =>'Triangle1').move_mouse
    @tapp.Node(:name =>'Node1').move_mouse
  end

  def test_executable_name
    exe_name = "testapp"
    if RUBY_PLATFORM=='i386-mswin32'
      verify_equal(exe_name.to_s+'.exe', TIMEOUT, "Executable Name should be correct."){ @tapp.executable_name }
    else     
      verify_equal(exe_name.to_s, TIMEOUT, "Executable Name should be correct."){ @tapp.executable_name }
    end  
  end

  def test_gesture   
    @tapp.Node( :name => 'Node1' ).set_attribute("visible", false)

    triangle = @tapp.Triangle(:name =>'Triangle1')
    old_y= triangle.attribute('y').to_i
    
    #direction, speed, distance and button
    triangle.gesture(:Up, 2, 200, {:button => :Left})
    verify_true(TIMEOUT, "Triangle did not move up"){ triangle.attribute('y').to_i < old_y.to_i }

    old_y= triangle.attribute('y').to_i
    triangle.gesture(:Down, 0.5, 55)
    verify_true(TIMEOUT, "Node did not move down"){ triangle.attribute('y').to_i > old_y.to_i }
    
    old_x = triangle.attribute('x').to_i 
    triangle.gesture(:Left, 0.5, 55)
    verify_true(TIMEOUT, "Node did not move left"){ triangle.attribute('x').to_i < old_x.to_i }
    
    old_x = triangle.attribute('x').to_i 
    triangle.gesture(:Right, 0.5, 55)
    verify_true(TIMEOUT, "Node did not move right"){ triangle.attribute('x').to_i > old_x.to_i }
  end

  def test_tap
    @tapp.ControlTab(:name => 'ControlTab').flick(:Up) 
    @tapp. Control( :name => 'AddRectangle' ).tap
    @tapp.ControlTab(:name => 'ControlTab').flick(:Down) 
     verify(TIMEOUT, "New Rectangle added") {
      @tapp.Rectangle( :name => 'Rectangle1' )
    }
  end
  
  def test_set_attribute
    triangle = @tapp.Triangle(:name =>'Triangle1')
    triangle.set_attribute('objectName','MyTriangle')
    
    verify(TIMEOUT, "Triangle changed ID name"){  @tapp.Triangle(:name =>'MyTriangle') }
  end
  
  def test_type
     type = @tapp.Triangle(:name =>'Triangle1').type
     verify_true(TIMEOUT, "Type of Triangle1 is not Triangle") {type=='Triangle'}
   end
   
  def test_state
    #test static state - nothing has changed
    stateTestApp = @tapp.state
    
    verify_true(TIMEOUT, "Failed to get the state object.") { (stateTestApp== @tapp.state) and  (stateTestApp != nil) }
    
    #change something and test again
    #should adding a new object to tree not change the state of the object?
    
    #@tapp.ControlTab(:name => 'ControlTab').flick(:Up) 
    #@tapp. Control( :name => 'AddRectangle' ).tap
    #@tapp.ControlTab(:name => 'ControlTab').flick(:Down) 
    #@tapp.refresh
    #newStateTestApp = @tapp.state
    #verify_true(TIMEOUT, "Failed to get the state object.") { (stateTestApp != newStateTestApp) and (newStateTestApp != nil) }
  end

  def test_get_parent
    verify_true(TIMEOUT, "The parent test object of is not correct") {
        @tapp.MainView( :name => 'MainView' ) == @tapp.NodeView( :name => 'NodeArea' ).get_parent}
  end

  def test_children
    obj = @tapp.MainView( :name => 'MainView').children({:objectType => 'Graphics'}, false)
    verify{obj.size == 3 }
  end
end

class TS_Testapp < Test::Unit::TestSuite
    def self.suite
        result = self.new(self.class.name)
        result << TC_Testapp.suite
    end

    def setup
    end

    def teardown
    end

    def run(*args)
        super
    end

end

Test::Unit::UI::Console::TestRunner.run(TS_Testapp)

# begin
#   include TDriverReport
#   create_test_unit_formatter()
# end
# module Test #:nodoc:all
#   module Unit
#     module UI
#       module Console
#         class TestRunner
#           def create_mediator(suite)
#             # swap in MATTI custom mediator
#             return TDriverReport::TestUnit.new(suite)
#           end
#         end
#       end
#     end
#   end
# end

