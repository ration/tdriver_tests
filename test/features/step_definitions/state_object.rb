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

Then /I set create xml state with (\d+) objects and store it in "([^\"]*)"$/ do | object_count, result_object |
  
  value = "<obj id=\"0\" name=\"root\" type=\"objects\">"
  
  (1..object_count.to_i).each do | iter |
  
    value << "<obj name=\"object_#{ iter }\" type=\"obj\" id=\"#{ iter }\"/>"
  
  end
  
  value << "</obj>"

  eval("#{ result_object }='#{ value }'")

end

