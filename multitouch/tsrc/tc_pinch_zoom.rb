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


require 'test/unit'
require 'tdriver'

class TC_Pinch < Test::Unit::TestCase

  def setup
	sut = TDriver.sut(:Id => 'sut_qt')
  
	@app = sut.run(:name => 'matti_multitouchapp')
	@app.log_qdebug(true)
  end

  def teardown
	@app.close
  end

  def test_pinch_zoom
	@app.MainWindow.pinch_zoom_in(2, 50, 0)	
	verify(5){@app.QGraphicsView.attribute('isTransformed') == 'true'}
	verify(5){@app.QGraphicsView.attribute('transformM11').to_i > 1}
	verify(5){@app.QGraphicsView.attribute('transformM22').to_i > 1}
	@app.MainWindow.pinch_zoom_out(2, 50, 0)	
	if @app.QGraphicsView.attribute('isTransformed') == 'true'
	  verify(5){@app.QGraphicsView.attribute('transformM11').to_i == 1}
	  verify(5){@app.QGraphicsView.attribute('transformM22').to_i == 1}
	end
  end

  def test_pinch_zoom_vertical
	@app.MainWindow.pinch_zoom_in(2, 50, :Vertical)	
	verify(5){@app.QGraphicsView.attribute('isTransformed') == 'true'}
	verify(5){@app.QGraphicsView.attribute('transformM11').to_i > 1}
	verify(5){@app.QGraphicsView.attribute('transformM22').to_i > 1}
	@app.MainWindow.pinch_zoom_out(2, 50, :Vertical)	
	if @app.QGraphicsView.attribute('isTransformed') == 'true'
	  verify(5){@app.QGraphicsView.attribute('transformM11').to_i == 1}
	  verify(5){@app.QGraphicsView.attribute('transformM22').to_i == 1}
	end
  end

  def test_pinch_zoom_horizontal
	@app.MainWindow.pinch_zoom_in(2, 50, :Horizontal)	
	verify(5){@app.QGraphicsView.attribute('isTransformed') == 'true'}
	verify(5){@app.QGraphicsView.attribute('transformM11').to_i > 1}
	verify(5){@app.QGraphicsView.attribute('transformM22').to_i > 1}
	@app.MainWindow.pinch_zoom_out(2, 50, :Horizontal)	
	if @app.QGraphicsView.attribute('isTransformed') == 'true'
	  verify(5){@app.QGraphicsView.attribute('transformM11').to_i == 1}
	  verify(5){@app.QGraphicsView.attribute('transformM22').to_i == 1}
	end
  end

  def test_pinch_zoom_degrees
	@app.MainWindow.pinch_zoom_in(2, 50, 75)	
	verify(5){@app.QGraphicsView.attribute('isTransformed') == 'true'}
	verify(5){@app.QGraphicsView.attribute('transformM11').to_i > 1}
	verify(5){@app.QGraphicsView.attribute('transformM22').to_i > 1}
	@app.MainWindow.pinch_zoom_out(2, 50, 25)	
	if @app.QGraphicsView.attribute('isTransformed') == 'true'
	  verify(5){@app.QGraphicsView.attribute('transformM11').to_i == 1}
	  verify(5){@app.QGraphicsView.attribute('transformM22').to_i == 1}
	end
  end

  def test_pinch_zoom_one_finger
	@app.MainWindow.pinch_zoom({:type => :in, :speed => 2, :distance_1 => 100, :distance_2 => 0, :direction => :Vertical, :differential => 10})
	verify(5){@app.QGraphicsView.attribute('isTransformed') == 'true'}
	verify(5){@app.QGraphicsView.attribute('transformM11').to_i > 1}
	verify(5){@app.QGraphicsView.attribute('transformM22').to_i > 1}
	@app.MainWindow.pinch_zoom({:type => :out, :speed => 2, :distance_1 => 100, :distance_2 => 0, :direction => 0, :differential => 10})
	if @app.QGraphicsView.attribute('isTransformed') == 'true'
	  verify(5){@app.QGraphicsView.attribute('transformM11').to_i == 1}
	  verify(5){@app.QGraphicsView.attribute('transformM22').to_i == 1}
	end
  end

end


