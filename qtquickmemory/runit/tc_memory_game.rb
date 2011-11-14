# Require ruby unit test framework: This enables execution of test cases and also includes assertions (Test::Unit::Assertions).
# The test methods starting with test_ found in TC_MemoryGame (or any Test::Unit::TestCase derived class)
# can be executed by running this file.
# QtQuickMemory: http://www.developer.nokia.com/Community/Wiki/A_QML_Memory_Game_Tutorial

require 'test/unit'

#Require QtQuickMemory test library
require File.expand_path( File.join( File.dirname( __FILE__ ), '../qt_quick_memory_lib/qt_quick_memory' ) )


class TC_MemoryGame < Test::Unit::TestCase

  # setup and teardown methods are always executed before each and after each test case method
  def setup

    # start the test application using the QtQuickMemory test library
    @qtquickmemory = QtQuickMemory.new

  end

  def teardown
  
    if @test_passed==false
     @qtquickmemory.close
    end

  end

  # NOTE: test_cases are executed in alphabetical order (not in the order they are defined)
  # This is one of the reasons why test cases must not have any sequential dependencies/coupling
  def test_start_new_game
    @qtquickmemory.start
    @qtquickmemory.verify_pairs_open
    @qtquickmemory.verify_clock_timer
    @qtquickmemory.pause_game
    @qtquickmemory.exit
  end
  
  def test_pause_game
    @qtquickmemory.start
    @qtquickmemory.verify_pairs_open
    @qtquickmemory.verify_clock_timer
    @qtquickmemory.pause_game
    @qtquickmemory.verify_clock_timer(false)
    @qtquickmemory.continue
    @qtquickmemory.verify_clock_timer
    @qtquickmemory.pause_game
    @qtquickmemory.exit
  end
  
  def test_open_one_pair
    @qtquickmemory.start
    @qtquickmemory.verify_pairs_open
    @qtquickmemory.open_pair(1+rand(15))
    @qtquickmemory.verify_pairs_open(1)
    @qtquickmemory.pause_game
    @qtquickmemory.exit
  end
  
  def test_complete_game
    @qtquickmemory.start
    @qtquickmemory.verify_pairs_open
    
    16.times do |pair_number|
      @qtquickmemory.open_pair(pair_number+1)
      @qtquickmemory.verify_pairs_open(pair_number+1)      
    end
    
    @qtquickmemory.verify_pairs_open(16)
    @qtquickmemory.verify_clock_timer(false)
    @qtquickmemory.verify_end_game
    @qtquickmemory.end_game
    @qtquickmemory.exit
  end
  

end
