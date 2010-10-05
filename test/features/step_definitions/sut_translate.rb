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


# Author: Ivan Castane
# Date: 05.10.2010
# Purpose: Test TDriver methods

When /^I set localisation parameters for mysql test environment$/ do
	MobyUtil::Parameter[ :user_data_db_type ] = "mysql"
	MobyUtil::Parameter[ :user_data_server_ip ] = "trmatti1.nmp.nokia.com" 
	MobyUtil::Parameter[ :user_data_server_username ] = "locale"
	MobyUtil::Parameter[ :user_data_server_password ] = "password"
	MobyUtil::Parameter[ :user_data_server_database_name ] = "matti_locale"
	MobyUtil::Parameter[ :user_data_server_database_tablename ] = "matti_testing_do_not_touch"
	
	MobyUtil::Parameter[ :localisation_db_type ] = "mysql"
	MobyUtil::Parameter[ :localisation_server_ip ] = "trmatti1.nmp.nokia.com" 
	MobyUtil::Parameter[ :localisation_server_username ] = "locale"
	MobyUtil::Parameter[ :localisation_server_password ] = "password"
	MobyUtil::Parameter[ :localisation_server_database_name ] = "matti_locale"
	MobyUtil::Parameter[ @sut.id ][ :language ] = "English-GB"
	MobyUtil::Parameter[ @sut.id  ][ :localisation_server_database_tablename ] = "matti_testing_do_not_touch"
end

When /^I set localisation parameters for sqlite test environment$/ do
	MobyUtil::Parameter[ :localisation_db_type ] = "sqlite"
	MobyUtil::Parameter[ :localisation_server_ip ] = "" 
	MobyUtil::Parameter[ :localisation_server_username ] = ""
	MobyUtil::Parameter[ :localisation_server_password ] = ""
	MobyUtil::Parameter[ :localisation_server_database_name ] = "./test_data/localization_data.sqlite"
	MobyUtil::Parameter[ @sut.id ][ :language ] = "Catalan"
	MobyUtil::Parameter[ @sut.id  ][ :localisation_server_database_tablename ] = "localization"

	MobyUtil::Parameter[ :user_data_db_type ] = "sqlite"
	MobyUtil::Parameter[ :user_data_server_ip ] = ""
	MobyUtil::Parameter[ :user_data_server_username ] = ""
	MobyUtil::Parameter[ :user_data_server_password ] = ""
	MobyUtil::Parameter[ :user_data_server_database_name ] = "./test_data/localization_data.sqlite"	
	MobyUtil::Parameter[ :user_data_server_database_tablename ] = "localization"
end

Then /^I get the translation "([^\"]*)"$/ do |translation|
  verify_true(10, "Failed to get translation.") { $translation == translation }
end

Then /^I get an "([^\"]*)" as a return type$/ do |type|
	verify_true(10, "Wrong return type on translation.") { $translation.class.to_s == type }
end

Then /^I get the translation "([^\"]*)" on the first value of the returned Array$/ do |translation|
  verify_true(10, "Failed to get translation.") { $translation[0] == translation }
end