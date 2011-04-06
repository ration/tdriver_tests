require 'test/unit'
require 'tdriver'

=begin
begin
  include TDriverReport
  create_test_unit_formatter()
end
module Test #:nodoc:all
  module Unit
	module UI
	  module Console
		class TestRunner
		  def create_mediator(suite)
			# swap in TDriver custom mediator
			return TDriverReport::TestUnit.new(suite)
		  end
		end
	  end
	end
  end
end
=end

class TC_Perf_Test < Test::Unit::TestCase

  def setup
	sut = TDriver.sut(:Id => 'sut_qt')
	time = Time.now
	@app = sut.run(:name => 'calculator')
	puts "App start time: " + (Time.now-time).to_s + "s"
  end

  def teardown
	time = Time.now
	@app.close
	puts "App close time: " + (Time.now-time).to_s + "s"
  end

  def test_button_taps
	time = Time.now
	100.times do
	  peform_calculation
	end
	puts "Test time: " + (Time.now-time).to_s + "s"
  end

  private
  def peform_calculation
	@app.child( :name => 'clearAllButton' ).tap
	@app.child(:name => 'fiveButton').tap
	@app.child(:name => 'timesButton').tap
	@app.child(:name => 'fiveButton').tap
	@app.child(:name => 'equalButton').tap
	verify_equal('25', 5){@app.QLineEdit( :name => 'display' ).attribute('text')}
  end

end
