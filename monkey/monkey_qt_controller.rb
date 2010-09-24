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

require 'monkey.rb'

qt_monkey = nil
begin
  
  qt_monkey = MobyBase::QtTDMonkey.new("testapp")
  
  5.times do
    
    begin
      
      if rand(3).to_i == 1
        qt_monkey.gorilla
      else
        qt_monkey.chimp
      end
      
    rescue MobyBase::TestObjectNotFoundError => e    
      puts e.inspect      
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
  
end

puts "TDMonkey finished"
