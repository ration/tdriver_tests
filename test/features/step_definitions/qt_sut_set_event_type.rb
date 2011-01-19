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


And("I enable listen to events for object \"$object\" in matti_multitouchapp") do |$object|
	eval ($object+".enable_events('ALL')")
end

Then("I tap object \"$object\" in matti_multitouchapp")do |$object|
	eval ($object+".tap_down")
	eval ($object+".tap_up")
end

Then("the results of \"$object\" should not contain \"$event_list\"") do | $object,$event_list|
	#puts @app.Square(:name =>'topLeft').get_events.to_s
	events = $event_list.split(',')
  events.each{ | event |
    verify_equal( false, 1, "Event #{ event } not found" ){ 
      eval ($object +".get_events.include?( event )")
    }
	}
end