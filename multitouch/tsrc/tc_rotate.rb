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


require 'test/unit'
require 'tdriver'

class TC_Rotate < Test::Unit::TestCase

  def setup
	sut = TDriver.sut(:Id => 'sut_qt')
	@app = sut.run(:name => 'matti_multitouchapp')
	@app.QToolButton( :text => 'NEXT' ).tap
  end

  def teardown
	@app.close
  end

  def test_rotate_clockwise_90
	@app.MainWindow.one_point_rotate(100, 0, :Clockwise, 90, 2)	
	verify_equal('90'){@app.Handle.attribute('rotation')}
  end

  def test_rotate_counter_clockwise_90
	@app.MainWindow.one_point_rotate(100, 0, :CounterClockwise, 90, 2)	
	verify_equal('-90'){@app.Handle.attribute('rotation')}
  end

  def test_rotate_clockwise_180
	@app.MainWindow.one_point_rotate(100, 0, :Clockwise, 180, 2)	
	verify_equal('180'){@app.Handle.attribute('rotation')}
  end

  def test_rotate_counter_clockwise_180
	@app.MainWindow.one_point_rotate(100, 0, :CounterClockwise, 180, 2)	
	verify_equal('180'){@app.Handle.attribute('rotation')}
  end

  def test_two_point_rotate_45
	@app.MainWindow.two_point_rotate(100, 0, :Clockwise, 45, 2)	
	verify_equal('45'){@app.Handle.attribute('rotation')}
  end

  def test_two_point_rotate_45_counter
	@app.MainWindow.two_point_rotate(100, 0, :CounterClockwise, 45, 2)	
	verify_equal('-45'){@app.Handle.attribute('rotation')}
  end

  def test_full_rotate_clockwise
	@app.MainWindow.one_point_rotate(100, 0, :Clockwise, 360, 2)	
	verify_equal('0'){@app.Handle.attribute('rotation')}
  end

  def test_full_two_point_rotate_clockwise
	@app.MainWindow.two_point_rotate(100, 0, :Clockwise, 360, 2)	
	verify_equal('0'){@app.Handle.attribute('rotation')}
  end

  def test_rotate
	@app.MainWindow.rotate({:type => :one_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 360, :speed => 3, :direction => :Vertical})
	verify_equal('0'){@app.Handle.attribute('rotation')}
	@app.MainWindow.rotate({:type => :one_point, :radius => 100, :rotate_direction => :CounterClockwise, :distance => 360, :speed => 3, :direction => 45})
	verify_equal('0'){@app.Handle.attribute('rotation')}
	@app.MainWindow.rotate({:type => :two_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 360, :speed => 3, :direction => 180})
	verify_equal('0'){@app.Handle.attribute('rotation')}
	@app.MainWindow.rotate({:type => :two_point, :radius => 100, :rotate_direction => :CounterClockwise, :distance => 360, :speed => 3, :direction => :Horizontal})
	verify_equal('0'){@app.Handle.attribute('rotation')}
  end

end


