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

# The testapp application example must be compiled and in PATH for these to work
# Author: Ville Kankainen
# Date: 27.10.2010
# Purpose: Testapp webkit 'browser' testapp helpers

require 'tdriver'


Then ("I verify that the page is loaded") do 
  verify(5) {
  	#color of the button changes when ready
  	@app.QDeclarativeRectangle(:color => '#00ffff')
  }
end

Then ("I move to page \"$url\"") do | url |
  width = @app.QDeclarativeView( :name => '' ).attribute("width").to_i
  width = 3*width/4
  @app.QDeclarativeRectangle( :name => 'urlbutton' ).drag(:Left,width)
  @app.QDeclarativeTextInput( :name => 'urltext' ).type_text(url)
  @app.QDeclarativeRectangle( :name => 'urlbutton' ).drag(:Right,width)
end