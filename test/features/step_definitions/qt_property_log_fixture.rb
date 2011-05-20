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


# Common step definitions for property logger fixture tests
# Author: Tuukka Lahtela
# Date: 06.05.2011

require 'tdriver'

When "I start to log property $property for object $name with interval $interval" do | property, name, interval |
  @app.child(:name => name).fixture('qt','logProperty',{:property => property, :filePath => 'c:\Data',:interval => interval})
end

When "I gesture $name object $direction for $distance pixels in $duration seconds" do |name, direction, distance, duration|
  @app.child(:name => name).gesture(direction.to_sym, 0.10, 10)
  @app.child(:name => name).gesture(direction.to_sym, duration, distance)
end

When "I wait $time second" do | time |
  sleep time.to_f
end

Then "I use $command to get property values for object $name property $property" do | command, name, property | 
  data = @__sut.state_object(@app.child( :name => name ).fixture('qt', command,{:property => property}))
  @entry_count = data.logData.attribute('entryCount').to_i
  verify_true(1){@entry_count != 0}
  verify_equal(property, 1){data.logData.name}
  verify_equal(name, 1){data.logData.attribute('objectName')}
end




