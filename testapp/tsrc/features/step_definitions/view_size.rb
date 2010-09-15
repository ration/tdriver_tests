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


# The test application must be in path for this to work.
require 'matti'
#require File.join( File.expand_path( ENV['MATTI_HOME'] ), 'matti.rb' )
#require File.join( File.dirname( __FILE__ ), '../../../../matti/lib/matti.rb' )

require 'spec/expectations'

include MattiVerify

Then("\"$app_name\" width no more than $width height no more than $height") do |app_name, width, height| 
  @test_app = @sut.application   
  @test_app.MainWindow(:name => 'MainWindow').attribute('width').to_i.should <= width.to_i
  @test_app.MainWindow(:name => 'MainWindow').attribute('height').to_i.should <= height.to_i 
end






