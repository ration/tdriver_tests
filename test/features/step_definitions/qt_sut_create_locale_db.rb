DEFAULT_LANGUAGE = "en_GB"

Given /^I set localisation parameters for mysql table creation$/ do
	TDriver::Parameter[ :localisation_db_type ] = "mysql"
	TDriver::Parameter[ :localisation_server_ip ] = "trmatti1.nmp.nokia.com" 
	TDriver::Parameter[ :localisation_server_username ] = "locale"
	TDriver::Parameter[ :localisation_server_password ] = "password"
	TDriver::Parameter[ :localisation_server_database_name ] = "matti_locale"
	TDriver::Parameter[ @sut.id ][ :language ] = DEFAULT_LANGUAGE
	TDriver::Parameter[ @sut.id  ][ :localisation_server_database_tablename ] = "temp_table_for_regression_test"
end

Given /^I set localisation parameters for sqlite table creation$/ do
	TDriver::Parameter[ :localisation_db_type ] = "sqlite"
	TDriver::Parameter[ :localisation_server_ip ] = "" 
	TDriver::Parameter[ :localisation_server_username ] = ""
	TDriver::Parameter[ :localisation_server_password ] = ""
	TDriver::Parameter[ :localisation_server_database_name ] = "./test_data/settings.sqlite"
	TDriver::Parameter[ @sut.id ][ :language ] = DEFAULT_LANGUAGE
	TDriver::Parameter[ @sut.id  ][ :localisation_server_database_tablename ] = "temp_table_for_regression_test"
end

Then /^I set the language to "([^\"]*)"$/ do |lan|
  TDriver::Parameter[ @sut.id ][ :language ] = lan
end

Then /^I restore the language to default$/ do
  TDriver::Parameter[ @sut.id ][ :language ] = DEFAULT_LANGUAGE
end

Then /^I can get the translation "([^\"]*)" for the symbol "([^\"]*)"$/ do |translation, symbol|
    verify_true(10, "Failed to get translation.") { @sut.translate(symbol.to_sym) == translation }
end

Then /^I can get the lengthvariant "([^\"]*)" with the translation "([^\"]*)" for the symbol "([^\"]*)"$/ do |lengthvar, translation, symbol|
    verify_true(10, "Failed to get translation.") { @sut.translate(symbol.to_sym, nil, nil, nil, lengthvar) == translation }
end

Then /^I can get the plurality "([^\"]*)" with the translation "([^\"]*)" for the symbol "([^\"]*)"$/ do |plurality, translation, symbol|
    verify_true(10, "Failed to get translation.") { @sut.translate(symbol.to_sym, nil, plurality) == translation }
end

Then /^I can drop the new table$/ do	
	db_type = TDriver::Parameter[ :localisation_db_type ]
	host = TDriver::Parameter[ :localisation_server_ip ]
	username = TDriver::Parameter[ :localisation_server_username ]
	password = TDriver::Parameter[ :localisation_server_password ]
	database_name = TDriver::Parameter[ :localisation_server_database_name ]
	table_name = TDriver::Parameter[ @sut.id  ][ :localisation_server_database_tablename ]
	connection = MobyUtil::DBConnection.new( db_type, host, database_name, username, password )
	MobyUtil::DBAccess.query(connection, "drop table #{ table_name };")
end

Then /^I can delete the new table$/ do

	# I need to terminate the sqlite connection to be able to remove the database file 
	# otherwhise i get permission denied
	db_type = TDriver::Parameter[ :localisation_db_type ]
	host = TDriver::Parameter[ :localisation_server_ip ]
	database_name = TDriver::Parameter[ :localisation_server_database_name ]
	MobyUtil::DBAccess.connections[ host + db_type + database_name ].dbh.close
    
	File.delete( TDriver::Parameter[ :localisation_server_database_name ] )
end
