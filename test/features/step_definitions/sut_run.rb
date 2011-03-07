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
      verify_equal( "1", 0, "Expected Testapp view EditArea. Checking by coordinates so make sure the app has not changed.") { @app.NodeView.attribute("x").to_s }
    when "EditArea"
      verify_equal( "-858", 0, "Expected Testapp view EditArea. Checking by coordinates so make sure the app has not changed.") { @app.NodeView.attribute("x").to_s }
    when "WebKitArea"
      verify_equal( "-1718", 0, "Expected Testapp view EditArea. Checking by coordinates so make sure the app has not changed.") { @app.NodeView.attribute("x").to_s }
    else
      
  end
end