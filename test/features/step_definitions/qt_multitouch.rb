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

require 'tdriver'
include TDriverVerify

Before do
  $ErrorMessage=""
end

When("I zoom in with params $speed, $distance, $direction") do |speed, distance, direction |
  @app.MainWindow.pinch_zoom_in(speed.to_i, distance.to_i, direction.to_i)
end

When("I press the next $count times") do |count|
  count = count.to_i
  while count > 0
	current_view = @app.MainWindow.attribute('currentView')
    @app.QToolButton( :text => 'NEXT' ).tap
	verify_true(5){@app.MainWindow.attribute('currentView') != current_view}
    count-=1
  end
end

When("I press all squares down") do 
  @app.tap_down_objects([@app.Square(:name =>'topLeft'), @app.Square(:name =>'topRight'), @app.Square(:name =>'lowRight'),@app.Square(:name =>'lowLeft')])
end

Then("the Graphicsview of the application should be transformed by the zoom") do
  verify_true(5){@app.QGraphicsView.attribute('transformM11').to_i > 1}
  verify_true(5){@app.QGraphicsView.attribute('transformM22').to_i > 1}
end

Then("the Graphicsview of the application should not be transformed by the zoom") do
  if @app.QGraphicsView.attribute('isTransformed') == 'true'
	verify_true(5){@app.QGraphicsView.attribute('transformM11').to_i == 1}
	verify_true(5){@app.QGraphicsView.attribute('transformM22').to_i == 1}
  end
end

Then("the Handle should be rotated $amount degrees") do |amount|
  if RUBY_PLATFORM.downcase.include?("mingw") and amount.to_i == 0
    rotation=@app.Handle.attribute('rotation')
    b_rotated=false    
    tolerance=100000000000000      
    if rotation < 0
      if rotation <= -35041414214731515-tolerance and rotation <= -35041414214731515+tolerance
        b_rotated=true
      end
    else
      if rotation >= 34972025275692415-tolerance and rotation <= 34972025275692415+tolerance
        b_rotated=true
      end
    end
    verify_true(){b_rotated}
  else
    verify_equal(amount){@app.Handle.attribute('rotation')}  
  end  
end

Then("all squares have been pressed $count times") do |count|
  verify_true(5){@app.Square( :name => 'topLeft' ).attribute('tapCount').to_i == count.to_i}
  verify_true(5){@app.Square( :name => 'topRight' ).attribute('tapCount').to_i == count.to_i}
  verify_true(5){@app.Square( :name => 'lowLeft' ).attribute('tapCount').to_i == count.to_i}
  verify_true(5){@app.Square( :name => 'lowRight' ).attribute('tapCount').to_i == count.to_i}
end

Then("all squares have been pressed down") do
  verify_true(5){@app.Square( :name => 'topLeft' ).attribute('pressed') == 'true'}
  verify_true(5){@app.Square( :name => 'topRight' ).attribute('pressed') == 'true'}
  verify_true(5){@app.Square( :name => 'lowLeft' ).attribute('pressed') == 'true'}
  verify_true(5){@app.Square( :name => 'lowRight' ).attribute('pressed') == 'true'}
end

Then("all squares have been released") do
  verify_true(5){@app.Square( :name => 'topLeft' ).attribute('pressed') == 'false'}
  verify_true(5){@app.Square( :name => 'topRight' ).attribute('pressed') == 'false'}
  verify_true(5){@app.Square( :name => 'lowLeft' ).attribute('pressed') == 'false'}
  verify_true(5){@app.Square( :name => 'lowRight' ).attribute('pressed') == 'false'}
end

Then("$count horizontal $length pixel lines appear on the screen") do |count, length|   
  i = 1
  while i <= count.to_i
	verify_equal(length.to_i, 5){(@app.Point(:name => 'EndPoint'+i.to_s ).attribute('x').to_i - @app.Point( :name => 'StartPoint'+i.to_s ).attribute('x').to_i).abs}
	i += 1
  end
end

Then("a $length pixel cross figure should be drawn on the screen") do |length|
  if @app.Point(:name => 'EndPoint1').attribute('y') != @app.Point( :name => 'EndPoint2').attribute('y')
	verify_equal(length.to_i, 5){(@app.Point(:name => 'EndPoint1').attribute('y').to_i - @app.Point( :name => 'EndPoint2').attribute('y').to_i).abs}
	verify_equal(length.to_i, 5){(@app.Point(:name => 'StartPoint3').attribute('x').to_i - @app.Point( :name => 'StartPoint4').attribute('x').to_i).abs}
  else
	verify_equal(length.to_i, 5){(@app.Point(:name => 'EndPoint3').attribute('y').to_i - @app.Point( :name => 'EndPoint4').attribute('y').to_i).abs}
	verify_equal(length.to_i, 5){(@app.Point(:name => 'StartPoint1').attribute('x').to_i - @app.Point( :name => 'StartPoint2').attribute('x').to_i).abs}
  end
end

Then("a $length pixel circle should be drawn on the screen") do |length|
  if @app.Point(:name => 'StartPoint1').attribute('x') != @app.Point( :name => 'StartPoint2').attribute('x')
  	verify_equal(length.to_i, 5){(@app.Point(:name => 'StartPoint1').attribute('x').to_i - @app.Point( :name => 'StartPoint2').attribute('x').to_i).abs}
  	verify_equal(length.to_i, 5){(@app.Point(:name => 'StartPoint3').attribute('y').to_i - @app.Point( :name => 'StartPoint4').attribute('y').to_i).abs}
  	verify_equal(length.to_i, 5){(@app.Point(:name => 'EndPoint1').attribute('y').to_i - @app.Point( :name => 'EndPoint2').attribute('y').to_i).abs}
  	verify_equal(length.to_i, 5){(@app.Point(:name => 'EndPoint3').attribute('x').to_i - @app.Point( :name => 'EndPoint4').attribute('x').to_i).abs}
  else
  	verify_equal(length.to_i, 5){(@app.Point(:name => 'StartPoint1').attribute('y').to_i - @app.Point( :name => 'StartPoint2').attribute('y').to_i).abs}
  	verify_equal(length.to_i, 5){(@app.Point(:name => 'StartPoint3').attribute('x').to_i - @app.Point( :name => 'StartPoint4').attribute('x').to_i).abs}
  	verify_equal(length.to_i, 5){(@app.Point(:name => 'EndPoint1').attribute('x').to_i - @app.Point( :name => 'EndPoint2').attribute('x').to_i).abs}
  	verify_equal(length.to_i, 5){(@app.Point(:name => 'EndPoint3').attribute('y').to_i - @app.Point( :name => 'EndPoint4').attribute('y').to_i).abs}
  end
end
