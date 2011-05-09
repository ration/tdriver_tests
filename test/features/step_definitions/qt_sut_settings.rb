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

require 'tdriver'
include TDriverVerify

Before do
  $ErrorMessage=""
end

Then("the $key value $value can be read") do |key, value |
  settings = @sut.read_settings({:organization => 'tDriver', :application => 'qttasserver'}, [key]) 
  verify_equal(value, 1){settings[key.to_sym]}
end

Then("I remove $key") do |key|
  @sut.remove_settings({:organization => 'tDriver', :application => 'qttasserver'}, [key]) 
end

Then("$key is removed") do |key|
  settings = @sut.read_settings({:organization => 'tDriver', :application => 'qttasserver'}, [key]) 
  verify_equal("",1){settings[key.to_sym]}
end

Then("the $key value $value can be read from $file") do | key, value, file |
  settings = @sut.read_settings({:fileName => file, :format => 'ini'}, [key]) 
  verify_equal(value, 1){settings[key.to_sym]}
end


Then("I clear ini setting $key from $file") do | key, file |
  @sut.remove_settings({:fileName => file, :format => 'ini'}, [key]) 
end

Then("$key is removed from $file") do | key, file |
  settings = @sut.read_settings({:fileName => file, :format => 'ini'}, [key]) 
  verify_equal("",1){settings[key.to_sym]}
end

Then("I insert a setting $key and value $value") do | key, value |
  @sut.set_settings({:organization => 'tDriver', :application => 'qttasserver'},{ key.to_sym => value})
end

Then("I write a setting $key and value $value to $file") do | key, value, file |
  @sut.set_settings({:fileName => file, :format => 'ini'},{ key.to_sym => value})
end

Then("the settings hash has a $key $value key value pair") do | key, value |
  verify_equal(value, 1){@settings[key.to_sym]}
end
