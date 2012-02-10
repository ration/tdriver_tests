# QtQuickMemory application test library
# Author: Mika Leman
# Date: 2.6.2011
# Purpose: To provide test methods for testing QtQuickMemory game

# The following line includes the complete tdriver environment
require 'tdriver'
include TDriverVerify
include TDriverReportTestUnit

class QtQuickMemory

  #Connect to sut and start the memory game
  def initialize
    @sut = TDriver.sut(:Id => "sut_symbian")  
	@app=@sut.run(:name => 'QtQuickMemory', :arguments => '-testability')
  end

  #Close memory game application
  def close   
	  @app.close
      verify_true(5){@sut.application.name=='homescreen'}
  end

    #Start memory game
  def start
    @app.MainMenu.QDeclarativeText(:text => 'Start').tap
  end
 
  #Verify the game timer
  def verify_clock_timer(is_running=true)
    verify(5, "Clock image should have been visible"){@app.Game.QDeclarativeImage(:source => /clock.PNG/,:visibleOnScreen => 'true')}
    #Get the timer test object using regexp match
    verify(5,"The timer should display minutes and seconds"){@app.Game.QDeclarativeText(:text => /\d:\d/)}
   
    current_time=@app.Game.QDeclarativeText(:text => /\d:\d/).attribute('text')
    sleep 2
    elapsed_time=@app.Game.QDeclarativeText(:text => /\d:\d/).attribute('text')
   
    verify_false(0,'The timer should be running'){current_time==elapsed_time} if is_running==true
    verify_true(0,'The timer should not be running'){current_time==elapsed_time} if is_running==false
  end
 
  #Verify current pairs open value
  #Default value is 0
  def verify_pairs_open(pairs_open=0)
    verify(10,"There should have been #{pairs_open} pairs open"){@app.Game.QDeclarativeText(:text => "Pairs Open: #{pairs_open}")}
  end
 
  def pause_game
    @app.Game.QDeclarativeImage(:source => /pause.PNG/).tap
  end
 
  def continue
    @app.MainMenu.QDeclarativeText(:text => 'Continue').tap
  end
 
  #Opens a pair
  def open_pair(pair_number=1)
    @app.Game.QDeclarativeGrid.Card(:parNumber => pair_number, :__index => 0).tap
    @app.Game.QDeclarativeGrid.Card(:parNumber => pair_number, :__index => 1).tap
  end
 
  #Verifies the end game screen
  def verify_end_game
    verify(5,"End game image should have been displayed"){@app.End.QDeclarativeImage(:source => /welldone.PNG/)}
    verify(5,"Well done text should have been displayed"){@app.End.QDeclarativeText(:text => 'WELL DONE!')}
  end
 
  #Confirms end game screen
  def end_game
    @app.End.QDeclarativeImage(:source => /welldone.PNG/).tap
  end
 
  #Exits the game
  def exit
    @app.MainMenu.QDeclarativeText(:text => 'Exit').tap
    verify_true(5){@sut.application.name=='homescreen'}
  end
  
end