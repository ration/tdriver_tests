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


# Common step definitions to be used in feature testing of TDriver
# Author: Mika Leiman
# Date: 25.9.2010
# Purpose: Steps used to test file transfer behaviour


require 'tdriver'
include TDriverVerify

Then "I generate test files" do
  FileUtils.mkdir_p 'test_files'
  for i in (1..10)
    File.open("test_files/test_file_#{i}.txt", 'w') do |f2|
      f2.puts 'some test data'
    end
  end
end

Then "the file \"$test_file\" is found from \"$location\" in sut" do |test_file, location|
  files=@sut.list_files_from_sut(:file => test_file, :from => location)  
  verify_true(0){files.include?("#{location}#{test_file}".gsub('\\','/'))}
end

Then "the file \"$test_file\" is not found from \"$location\" in sut" do |test_file, location|
  files=@sut.list_files_from_sut(:file => test_file, :from => location)
  verify_false(0){files.include?("#{location}#{test_file}".gsub('\\','/'))}
end

Then "I can delete the file \"$test_file\" from \"$location\" in sut" do |test_file,location|
  @sut.delete_from_sut(:from => location, :file => test_file)
end

Then "I can delete the test files" do
  FileUtils::remove_entry_secure('test_files', :force => true)
end