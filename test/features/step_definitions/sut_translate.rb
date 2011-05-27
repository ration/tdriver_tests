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
	TDriver::Parameter[ :localisation_db_type ] = "mysql"
	TDriver::Parameter[ :localisation_server_ip ] = "trmatti1.nmp.nokia.com" 
	TDriver::Parameter[ :localisation_server_username ] = "locale"
	TDriver::Parameter[ :localisation_server_password ] = "password"
	TDriver::Parameter[ :localisation_server_database_name ] = "matti_locale"
	TDriver::Parameter[ @sut.id ][ :language ] = "English-GB"
	TDriver::Parameter[ @sut.id  ][ :localisation_server_database_tablename ] = "matti_testing_do_not_touch"
	
	TDriver::Parameter[ :user_data_db_type ] = "mysql"
	TDriver::Parameter[ :user_data_server_ip ] = "trmatti1.nmp.nokia.com" 
	TDriver::Parameter[ :user_data_server_username ] = "locale"
	TDriver::Parameter[ :user_data_server_password ] = "password"
	TDriver::Parameter[ :user_data_server_database_name ] = "matti_locale"
	TDriver::Parameter[ @sut.id  ][ :user_data_server_database_tablename ] = "matti_testing_do_not_touch"
	
	TDriver::Parameter[ :operator_data_db_type ] = "mysql"
	TDriver::Parameter[ :operator_data_server_ip ] = "trmatti1.nmp.nokia.com" 
	TDriver::Parameter[ :operator_data_server_username ] = "locale"
	TDriver::Parameter[ :operator_data_server_password ] = "password"
	TDriver::Parameter[ :operator_data_server_database_name ] = "matti_locale"
	TDriver::Parameter[ @sut.id  ][ :operator_data_server_database_tablename ] = "operator_testing_do_not_touch"
	TDriver::Parameter[ @sut.id  ][ :operator_selected ] = "Orange"
end

When /^I set localisation parameters for sqlite test environment$/ do
	TDriver::Parameter[ :localisation_db_type ] = "sqlite"
	TDriver::Parameter[ :localisation_server_ip ] = "" 
	TDriver::Parameter[ :localisation_server_username ] = ""
	TDriver::Parameter[ :localisation_server_password ] = ""
	TDriver::Parameter[ :localisation_server_database_name ] = "./test_data/localization_data.sqlite"
	TDriver::Parameter[ @sut.id ][ :language ] = "Catalan"
	TDriver::Parameter[ @sut.id  ][ :localisation_server_database_tablename ] = "localization"

	TDriver::Parameter[ :user_data_db_type ] = "sqlite"
	TDriver::Parameter[ :user_data_server_ip ] = ""
	TDriver::Parameter[ :user_data_server_username ] = ""
	TDriver::Parameter[ :user_data_server_password ] = ""
	TDriver::Parameter[ :user_data_server_database_name ] = "./test_data/localization_data.sqlite"	
	TDriver::Parameter[ @sut.id  ][ :user_data_server_database_tablename ] = "localization"
	
	TDriver::Parameter[ :operator_data_db_type ] = "sqlite"
	TDriver::Parameter[ :operator_data_server_ip ] = ""
	TDriver::Parameter[ :operator_data_server_username ] = ""
	TDriver::Parameter[ :operator_data_server_password ] = ""
	TDriver::Parameter[ :operator_data_server_database_name ] = "./test_data/operator_data.sqlite"	
	TDriver::Parameter[ @sut.id  ][ :operator_data_server_database_tablename ] = "operator_data"
	TDriver::Parameter[ @sut.id  ][ :operator_selected ] = "Orange"
end

Then /^I get the translation "([^\"]*)"$/ do |translation|
  verify_true(0, "Failed to get translation.") { $translation == translation }
end

Then /^I get an "([^\"]*)" as a return type$/ do |type|
	verify_true(0, "Wrong return type on translation.") { $translation.class.to_s == type }
end

Then /^I get the translation "([^\"]*)" on the first value of the returned Array$/ do |translation|
  verify_true(0, "Failed to get translation.") { $translation[0] == translation }
end
