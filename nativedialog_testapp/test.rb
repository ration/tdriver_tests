STDOUT.sync = true
require 'tdriver'
include TDriverVerify

puts "Connect SUT"
@sut = TDriver.connect_sut(:Id => 'sut_qt')

puts "Check dialogfixture"
MobyUtil::Parameter[:sut_qt][:fixtures][:dialog] = "dialogfixture"
puts "-------------------"
puts @sut.fixture('dialog', 'fixture_id') 
puts "-------------------"

puts "Run nativedialog_testapp"
@app = @sut.run( :name => "nativedialog_testapp", :arguments => "-testability")

# TODO: make it so that the sleeps are not needed!

puts "Open a dialog first time"
@app.QToolButton( :text => 'Open' ).tap
sleep 1
puts "Dump contents"
puts "-------------------"
puts @sut.fixture('dialog', 'dump_dialog', { :dialog_name => "Open"} )
puts "-------------------"
puts "Do Cancel button"
@sut.fixture('dialog', 'tap_control', { :dialog_name => "Open", :name_pattern => "Cancel", :class_pattern => "Button" } )
sleep 1

puts "Open a dialog second time"
@app.QToolButton( :text => 'Open' ).tap
sleep 1
puts "Insert file name into dialog"
@sut.fixture('dialog', 'send_text', { :dialog_name => "Open", :class_pattern => "ComboBoxEx32", :text => "runner.bat" } )
sleep 1
puts "Do Open button"
@sut.fixture('dialog', 'tap_control', { :dialog_name => "Open", :name_pattern => "Open", :class_pattern => "Button" } )
sleep 1

puts "Exit"
# This closes the currently active application on SUT.
@sut.application.close