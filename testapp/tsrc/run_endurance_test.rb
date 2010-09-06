############################################################################
## 
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
## All rights reserved. 
## Contact: Nokia Corporation (testabilitydriver@nokia.com) 
## 
## This file is part of MATTI. 
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


iter = 0
time = Time.now
file_name = time.strftime('endurance_%d%m%Y.log')
output = File.open(file_name, 'w+')
output.puts(time.strftime('Endurance run started %H:%M %d.%m.%Y'))
output.flush
while iter < 200
  iter = iter + 1
  start_time = Time.now
  failure = system("cucumber features -f MattiReport::CucumberListener")
  #failure = system("cucumber features")
  if(failure != true or $? != 0)
	puts "FAIL"
  end
  end_time = Time.now
  puts("Iteration "<< iter.to_s << " took " << (end_time-start_time).to_s << "sec")
  #output.flush
end
time = Time.now
output.puts(time.strftime('Endurance run ended %H:%M %d/%m/%Y.log'))
output.close
