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
# Author: Mika Leiman
# Date: 29.10.2010
# Purpose: Steps used to test gesture points behaviour

Then("I drag node $number to the center of the screen") do | number |
  verify(30) {
  window_width = @sut.application.NodeView.attribute('width').to_i/2
  window_height = @sut.application.NodeView.attribute('height').to_i/2
  window_x = @sut.application.NodeView.attribute('x_absolute').to_i + window_width.to_i
  window_y = @sut.application.NodeView.attribute('y_absolute').to_i + window_height.to_i
  @nodeid = "Node"+number.to_s
  @sut.application.Node(:name => @nodeid).drag_to(window_x.to_i, window_y.to_i)
  node_width = @sut.application.Node(:name => @nodeid).attribute('width').to_i/2
  node_height = @sut.application.Node(:name => @nodeid).attribute('height').to_i/2
  new_x = @sut.application.Node(:name => @nodeid).attribute('x').to_i+node_width.to_i
  new_y = @sut.application.Node(:name => @nodeid).attribute('y').to_i+node_height.to_i

  	x_tolerance=false
  	if window_width.to_i - 5 < new_x.to_i && window_width.to_i + 5 > new_x.to_i
			x_tolerance=true
  	end
  	y_tolerance=false
  	if window_height.to_i - 5 < new_y.to_i && window_height.to_i + 5 > new_y.to_i
			y_tolerance=true
  	end
  	raise "x tolerance not accepted" unless x_tolerance
  	raise "y tolerance not accepted" unless y_tolerance
  }
end

