############################################################################
##
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
## All rights reserved.
## Contact: Nokia Corporation (testabilitydriver@nokia.com)
##
## This file is part of Testability Driver.
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

require 'monkey_example_configuration.rb'

# A list of exceptions that will cause video recording to stop
rec_stop_exceptions = [ "MobyBase::TestObjectNotFoundError", "ArgumentError" ]

rec_options = { :width => 480, :height => 640, :fps => 15 }  
# rec_options[ :device ] = "dev0"  # Set the device if required, otherwise the default recording device will be used
monkey_recorder = MobyUtil::TDriverCam.new_cam( "monkey_recording.avi", rec_options )
monkey_recorder.start_recording      

qt_monkey = nil

begin
  
  qt_monkey = MobyBase::QtTDMonkey.new("testapp")   
  
  5.times do
    
    begin # handle any exceptions not affecting recording in the usual way
      begin # first see if the exception halts recording
        if rand(3).to_i == 1
          qt_monkey.gorilla
        else
          qt_monkey.chimp
        end
            
      rescue Exception => e
        rse_match = false
        rec_stop_exceptions.each do | rse |
          if e.kind_of? rse         
            rse_match = true
            monkey_recorder.stop_recording
            # do something else with error situation
            break
          end          
        end
        raise e unless rse_match
      end 
    rescue MobyBase::TestObjectNotVisibleError => e    
      puts e.inspect
    rescue MobyBase::TDMonkeyError => e    
      puts e.inspect

    end  
  end
rescue MobyBase::TDMonkeyError => me
  
  puts "Rescued TDMonkey error:"
  puts me.inspect
  
rescue Exception => e
  
  puts "Rescued generic error"
  puts e.inspect
  raise e

ensure
  monkey_recorder.stop_recording
end

puts "TDMonkey finished"
