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
# Date: 15.03.2011
# Purpose: Test TDriver methods


And /^I perform some gestures and stop recording$/ do
	raise @__exception if @__exception != nil
	
	@app.Menu.ControlTab.flick(:Up)
	@app.Menu.Control(:name => 'Reset').tap
	@app.Menu.Control(:name => 'AddNode').tap
	@app.Menu.Control(:name => 'AddNode').tap 
	@app.Menu.Control(:name => 'AddNode').tap  
	@app.Menu.Control(:name => 'AddNode').tap 
	@app.Menu.ControlTab.flick(:Down)
	@script = MobyUtil::Recorder.print_script(@__sut, @app)	
end

Then /^I am able to play the recording$/ do 
	raise @__exception if @__exception != nil

	@app.Triangle.tap_up 
	@app.Menu.ControlTab.flick(:Up)
	@app.Menu.Control(:name => 'Reset').tap 
	@app.Menu.ControlTab.flick(:Down)
	
	@script.gsub!('sut','@__sut')
	#puts @script
	eval(@script)
	
	verify_equal('4', 30){@app.NodeView.attribute('nodeCount')}
end

And /^I start recording and perform some gestures$/ do
	raise @__exception if @__exception != nil
	
	MobyUtil::Recorder.start_rec(@app)
	@app.Menu.ControlTab.flick(:Up)
	@app.Menu.Control(:name => 'Reset').tap
	@app.Menu.Control(:name => 'AddNode').tap
	@app.Menu.Control(:name => 'AddNode').tap 
	@app.Menu.Control(:name => 'AddNode').tap  
	@app.Menu.Control(:name => 'AddNode').tap 
	@app.Menu.ControlTab.flick(:Down)
end