Given /^I set localisation parameters for mysql table creation$/ do
	MobyUtil::Parameter[ :localisation_db_type ] = "mysql"
	MobyUtil::Parameter[ :localisation_server_ip ] = "trmatti1.nmp.nokia.com" 
	MobyUtil::Parameter[ :localisation_server_username ] = "locale"
	MobyUtil::Parameter[ :localisation_server_password ] = "password"
	MobyUtil::Parameter[ :localisation_server_database_name ] = "matti_locale"
	MobyUtil::Parameter[ @sut.id ][ :language ] = "en_GB"
	MobyUtil::Parameter[ @sut.id  ][ :localisation_server_database_tablename ] = "temp_table_for_regression_test"
end

Given /^I set localisation parameters for sqlite table creation$/ do
	MobyUtil::Parameter[ :localisation_db_type ] = "sqlite"
	MobyUtil::Parameter[ :localisation_server_ip ] = "" 
	MobyUtil::Parameter[ :localisation_server_username ] = ""
	MobyUtil::Parameter[ :localisation_server_password ] = ""
	MobyUtil::Parameter[ :localisation_server_database_name ] = "./test_data/settings.sqlite"
	MobyUtil::Parameter[ @sut.id ][ :language ] = "en_GB"
	MobyUtil::Parameter[ @sut.id  ][ :localisation_server_database_tablename ] = "temp_table_for_regression_test"
end

Then /^I can get the translation "([^\"]*)" from the new table$/ do |translation|
    verify_true(10, "Failed to get translation.") { @sut.translate(:qtn_sett_main_title, nil, nil, nil, "1") == translation }
	MobyUtil::Parameter[ @sut.id ][ :language ] = "id"
	verify_true(10, "Failed to get translation.") { @sut.translate(:qtn_sett_main_title, nil, nil, nil, "1") == translation }
	MobyUtil::Parameter[ @sut.id ][ :language ] = "en_GB"
end

Then /^I can drop the new table$/ do	
	db_type = MobyUtil::Parameter[ :localisation_db_type ]
	host = MobyUtil::Parameter[ :localisation_server_ip ]
	username = MobyUtil::Parameter[ :localisation_server_username ]
	password = MobyUtil::Parameter[ :localisation_server_password ]
	database_name = MobyUtil::Parameter[ :localisation_server_database_name ]
	table_name = MobyUtil::Parameter[ @sut.id  ][ :localisation_server_database_tablename ]
	connection = MobyUtil::DBConnection.new( db_type, host, database_name, username, password )
	MobyUtil::DBAccess.query(connection, "drop table #{ table_name };")
end

Then /^I can delete the new table$/ do

	# I need to terminate the sqlite connection to be able to remove the database file 
	# otherwhise i get permission denied
	db_type = MobyUtil::Parameter[ :localisation_db_type ]
	host = MobyUtil::Parameter[ :localisation_server_ip ]
	database_name = MobyUtil::Parameter[ :localisation_server_database_name ]
	MobyUtil::DBAccess.connections[ host + db_type + database_name ].dbh.close()
    
	File.delete( MobyUtil::Parameter[ :localisation_server_database_name ] )
end