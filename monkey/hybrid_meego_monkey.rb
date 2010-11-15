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

monkey_minutes = 10

begin
  if ARGV.size > 0
    monkey_minutes = ARGV[0].to_i
  end
rescue
end

puts "Exercising monkey for #{monkey_minutes} minutes."

meego_monkey = nil
begin

  party_over = Time.now + (monkey_minutes * 60)
  meego_monkey = MobyBase::MeeGoMonkey.new()
  while (Time.now < party_over) do

    begin

      if rand(3).to_i == 1
        meego_monkey.gorilla
      else
        meego_monkey.chimp
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

