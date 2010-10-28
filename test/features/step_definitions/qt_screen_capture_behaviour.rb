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
# Date: 27.10.2010
# Purpose: Steps used to test screen capture behaviour


require 'tdriver'
include TDriverVerify
include TDriverReportAPI

Then "I can use the image data and write it to a file \"$file\"" do |file|    

  verify_true(0,"Screen capture data received"){@screen_capture_data.class==String}
  verify_true(0,"Screen capture data contains image data"){@screen_capture_data.size>1000}
  
  File.open(file, 'wb:binary') {|f2| f2.puts @screen_capture_data}
  
end

Then "the coordinates of clear all button are found" do  
  tdriver_report_log("Calculator clear all button x coordinate is #{@clear_all_button_coordinates[0]}")
  tdriver_report_log("Calculator clear all button y coordinate is #{@clear_all_button_coordinates[1]}")
  verify_true(0,"Clear all x coordinate should be greater than 0"){@clear_all_button_coordinates[0]>0}
  verify_true(0,"Clear all y coordinate should be greater than 0"){@clear_all_button_coordinates[1]>0}
end

Then "clear all button image is found" do
  verify_true(0,"Clear all button should be found"){@clear_all_button_image_found}
end
