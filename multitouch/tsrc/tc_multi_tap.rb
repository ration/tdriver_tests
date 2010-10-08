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

class TC_MultiTap < Test::Unit::TestCase

  def setup
	@sut = TDriver.sut(:Id => 'sut_qt')
	@app = @sut.run(:name => 'matti_multitouchapp')
	@sut.set_event_type(:Both)
	@app.QToolButton( :text => 'NEXT' ).tap(2)
  end

  def teardown
	@sut.set_event_type(:Both)
	@app.close
  end

  def test_simultaneous_tap
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('tapCount').to_i == 0}
	verify_true(1){ @app.Square( :name => 'topRight' ).attribute('tapCount').to_i == 0}
	@app.tap_objects([@app.Square( :name => 'topLeft' ), @app.Square( :name => 'topRight' )])
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('tapCount').to_i == 1}
	verify_true(1){ @app.Square( :name => 'topRight' ).attribute('tapCount').to_i == 1}
  end

  def test_simultaneous_tap_down_up
	@app.tap_down_objects([@app.Square( :name => 'topLeft' ), @app.Square( :name => 'topRight' ), @app.Square( :name => 'lowRight'),@app.Square( :name => 'lowLeft' )])
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('pressed') == 'true'}
	verify_true(1){ @app.Square( :name => 'topRight' ).attribute('pressed') == 'true'}
	verify_true(1){ @app.Square( :name => 'lowLeft' ).attribute('pressed') == 'true'}
	verify_true(1){ @app.Square( :name => 'lowRight' ).attribute('pressed') == 'true'}

	@app.tap_up_objects([@app.Square( :name => 'topLeft' ), @app.Square( :name => 'topRight' )])
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('pressed') == 'false'}
	verify_true(1){ @app.Square( :name => 'topRight' ).attribute('pressed') == 'false'}
	verify_true(1){ @app.Square( :name => 'lowLeft' ).attribute('pressed') == 'true'}
	verify_true(1){ @app.Square( :name => 'lowRight' ).attribute('pressed') == 'true'}

	@app.tap_up_objects([@app.Square( :name => 'lowLeft' ), @app.Square( :name => 'lowRight' )])
	verify_true(1){ @app.Square( :name => 'lowLeft' ).attribute('pressed') == 'false'}
	verify_true(1){ @app.Square( :name => 'lowRight' ).attribute('pressed') == 'false'}

  end

  def test_tap_down_tap_tap_up	
	@sut.set_event_type(:Touch)
	@app.Square( :name => 'topLeft' ).tap_down
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('pressed') == 'true'}
	@app.Square( :name => 'topRight' ).tap_down
	verify_true(1){ @app.Square( :name => 'topRight' ).attribute('pressed') == 'true'}
	@app.Square( :name => 'lowLeft' ).tap_down
	verify_true(1){ @app.Square( :name => 'lowLeft' ).attribute('pressed') == 'true'}
	@app.Square( :name => 'lowRight' ).tap_down
	verify_true(1){ @app.Square( :name => 'lowRight' ).attribute('pressed') == 'true'}
	@app.Square( :name => 'topLeft' ).tap_up
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('pressed') == 'false'}
	@app.Square( :name => 'topRight' ).tap_up
	verify_true(1){ @app.Square( :name => 'topRight' ).attribute('pressed') == 'false'}
	@app.Square( :name => 'lowLeft' ).tap_up
	verify_true(1){ @app.Square( :name => 'lowLeft' ).attribute('pressed') == 'false'}
	@app.Square( :name => 'lowRight' ).tap_up
	verify_true(1){ @app.Square( :name => 'lowRight' ).attribute('pressed') == 'false'}
  end

  def test_tap_object_coordinates	
	@sut.set_event_type(:Touch)
	x = @app.MultiTapView( :name => 'tapView' ).attribute('width').to_i;
	y = @app.MultiTapView( :name => 'tapView' ).attribute('height').to_i;
	@app.MultiTapView( :name => 'tapView' ).tap_down_object(x/4 , y/4)
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('pressed') == 'true'}
	@app.MultiTapView( :name => 'tapView' ).tap_object(x/1.25 , y/1.25)
	@app.MultiTapView( :name => 'tapView' ).tap_up_object(x/4 , y/4)
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('pressed') == 'false'}
	verify_true(1){ @app.Square( :name => 'lowRight' ).attribute('tapCount').to_i == 1}
  end

  def _test_tap_object_coordinates_2
	@sut.set_event_type(:Touch)
	x = @app.MultiTapView( :name => 'tapView' ).attribute('width').to_i;
	y = @app.MultiTapView( :name => 'tapView' ).attribute('height').to_i;
	@app.MultiTapView( :name => 'tapView' ).tap_down_object(x/4 , y/4)
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('pressed') == 'true'}
	@app.MultiTapView( :name => 'tapView' ).tap_down_object(x/1.25 , y/1.25)
	verify_true(1){ @app.Square( :name => 'lowRight' ).attribute('pressed') == 'true'}
	@app.MultiTapView( :name => 'tapView' ).tap_up_object(x/1.25 , y/1.25)
	verify_true(1){ @app.Square( :name => 'lowRight' ).attribute('pressed') == 'false'}
	@app.MultiTapView( :name => 'tapView' ).tap_up_object(x/4 , y/4)
	verify_true(1){ @app.Square( :name => 'topLeft' ).attribute('tapCount').to_i == 1}
	verify_true(1){ @app.Square( :name => 'lowRight' ).attribute('tapCount').to_i == 1}
  end

end
