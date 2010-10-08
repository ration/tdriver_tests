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

class TC_Multigesture < Test::Unit::TestCase

  def setup
	sut = TDriver.sut(:Id => 'sut_qt')
	@app = sut.run(:name => 'matti_multitouchapp')
	@app.QToolButton( :text => 'NEXT' ).tap(3)
  end

  def teardown
	#@app.close
  end

  def test_two_gestures	
	@app.multi_touch{
#	  @app.MultiGestureView.gesture(:Right, 1, 50)
#	  @app.MultiGestureView.gesture(:Up, 2, 150)
#	  @app.MultiGestureView.gesture(:Left, 2, 150)
	  @app.MultiGestureView.pinch_zoom({:type => :in, :speed => 2, :distance_1 => 100, :distance_2 => 100, :direction => 0, :differential => 100,:x => 400, :y => 300})
#	  @app.MultiGestureView.rotate({:type => :two_point, :radius => 100, :rotate_direction => :Clockwise, :distance => 360, :speed => 3, :direction => 180, :x => 100, :y => 100})	  
	}
  end

end


