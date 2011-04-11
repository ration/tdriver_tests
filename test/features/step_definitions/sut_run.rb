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

# In test app, to check that a certain view is visible
# for now we check for the value of the attribute "x"
Then /^"([^"]*)" view is visible$/ do |view_name|
  case( view_name)
    when "NodeArea"
      verify( 5, "Expected Testapp view Node area is visible.") { @app.Menu(:visibleOnScreen => 'true') }
    when "EditArea"
      verify( 5, "Expected Testapp view Node area not visible.") { @app.Menu(:visibleOnScreen => 'false') }
      verify( 5, "Expected Testapp webkit not visible.") { @app.WebKitView( :name => 'WebKitArea' ).QGraphicsProxyWidget(:visibleOnScreen => 'false') }
    when "WebKitArea"
      verify( 5, "Expected Testapp view EditArea.") { @app.WebKitView( :name => 'WebKitArea' ).QGraphicsProxyWidget(:visibleOnScreen => 'true') }
    else
      
  end
end