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


# Author: Bilkis Gargadia
# Date: 03.11.2010
# Purpose: Test TDriver methods

And "I get the coordinates for the Quit button as \"$x\" and \"$y\"" do |$x,$y|
  control = @__sut.application.NodeView.Control( :name => 'Quit' )
  x = control.attribute('x').to_i+10
  y = control.attribute('y').to_i+10
  x = x + ( control.attribute('width').to_i / 2 )
  y = y + ( control.attribute('height').to_i / 2 )
  eval ("#{$x}=x")
  eval ("#{$y}=y")
end