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

class TC_Multitouch < Test::Unit::TestCase

  def setup
	sut = TDriver.sut(:Id => 'sut_qt')
	@app = sut.run(:name => 'matti_multitouchapp')
  end

  def teardown
	@app.close
  end

  def test_invalid_params_rotate
	assert_raises(ArgumentError) do 
	  @app.MainWindow.one_point_rotate('100', 0, :Clockwise, 45, 2)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.one_point_rotate(100, 361, :Clockwise, 45, 2)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.one_point_rotate(100, 0, :Suoraan, 45, 2)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.one_point_rotate(100, 0, :Clockwise, 361, 2)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.one_point_rotate(100, 0, :Clockwise, 45, 'nopsaan')
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.two_point_rotate('100', 0, :Clockwise, 45, 2)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.two_point_rotate(100, 361, :Clockwise, 45, 2)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.two_point_rotate(100, 0, :Suoraan, 45, 2)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.two_point_rotate(100, 0, :Clockwise, 361, 2)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.two_point_rotate(100, 0, :Clockwise, 45, 'nopsaan')
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.rotate({:type => :three_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 100, :speed => 2, :direction => 0})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.rotate({:type => :two_point, :radius => '100', :rotate_direction => :Clockwise, :distance => 100, :speed => 2, :direction => 0})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.rotate({:type => :two_point, :radius => 100, :rotate_direction => :Clockwe, :distance => 100, :speed => 2, :direction => 0})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.rotate({:type => :two_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 'foo', :speed => 2, :direction => 0})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.rotate({:type => :one_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 100, :speed => '2', :direction => 0})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.rotate({:type => :one_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 100, :speed => 2, :direction => 363})
	end
  end

  def test_invalid_params_pinch
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom_in(2, 100, 'foo')
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom_in(2, 100, 400)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom_in(2, 100, :Up)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom_out(2, 100, 'foo')
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom_out(2, 100, 400)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom_out(2, 100, :Up)
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom({:type => :left, :speed => 2, :distance_1 => 100, :distance_2 => 100, :angle => :Vertical, :differential => 10})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom({:type => :out, :speed => 'nopsaan', :distance_1 => 100, :distance_2 => 100, :angle => :Vertical, :differential => 10})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom({:type => :in, :speed => 2, :distance_1 => 'kuus', :distance_2 => 100, :angle => :Vertical, :differential => 10})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom({:type => :in, :speed => 2, :distance_1 => 100, :distance_2 => 'sata', :angle => :Vertical, :differential => 10})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom({:type => :in, :speed => 2, :distance_1 => 100, :distance_2 => 100, :angle => :Vertti, :differential => 10})
	end
	assert_raises(ArgumentError) do 
	  @app.MainWindow.pinch_zoom({:type => :in, :speed => 2, :distance_1 => 100, :distance_2 => 100, :angle => :Vertical, :differential => 'iso'})
	end

  end
end


