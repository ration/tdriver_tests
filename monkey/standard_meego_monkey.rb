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

require 'meego_monkey_configuration.rb'

monkey_time = 10

begin
  if ARGV.size > 0
    monkey_time = ARGV[0].to_i
  end
rescue
end

puts "Exercising monkey #{monkey_time} times."

meego_monkey = nil
begin

  meego_monkey = MobyBase::MeeGoMonkey.new()
  monkey_time.times do

    begin

      meego_monkey.gorilla

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

