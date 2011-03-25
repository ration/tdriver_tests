############################################################################
## 
## Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies). 
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

Given /^I start the recorder and do tap some buttons$/ do
  begin
  MobyUtil::Recorder.start_rec( @app )
  @app.Button(:text=>'1').tap
  @app.Button(:text=>'2').tap
  rescue Exception => e
    put e
  end
end

Then /^I am able to play the correct ruby script$/ do
  # check for expected lines
  verify_true(1){ ! @ruby_script.match(/@app\.Button\( :name=>'oneButton' \)\.tap/m).nil?}
  verify_true(1){ ! @ruby_script.match(/@app\.Button\( :name=>'twoButton' \)\.tap/m).nil?}
  # run script
  @ruby_script.gsub!("sut", "@__sut")
  eval( @ruby_script )
end


