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


# Author: Mika Leiman
# Date: 5.1.2011
# Purpose: Test TDriver methods

require 'tdriver'
include TDriverVerify
include TDriverReportAPI

Before do
  	
  @verify_timeout=0 if @verify_timeout==nil

  $on_error_verify_block_executed = nil

end


Given ("that I call verify_false with no timeout value") do
    
    begin      
      verify_start_time=Time.now
      verify_false(){true==true}
    rescue Exception => e
     
    end
    @verify_timeout=Time.now - verify_start_time
    tdriver_report_log( "Verify timeout in #{@verify_timeout}s")
end

Given ("that I call verify_false with timeout $timeout") do |timeout|
    begin
      verify_start_time=Time.now
      verify_false(timeout.to_i){true==true}
    rescue Exception => e
      
    end
    @verify_timeout=Time.now - verify_start_time
    tdriver_report_log( "Verify timeout in #{@verify_timeout}s")
end

Given ("that I call verify_true with no timeout value") do

    begin
      verify_start_time=Time.now
      verify_true(){true==false}
    rescue Exception => e

    end
    @verify_timeout=Time.now - verify_start_time
    tdriver_report_log( "Verify timeout in #{@verify_timeout}s")
end

Given ("that I call verify_true with timeout $timeout") do |timeout|
    begin
      verify_start_time=Time.now
      verify_true(timeout.to_i){true==false}
    rescue Exception => e

    end
    @verify_timeout=Time.now - verify_start_time
    tdriver_report_log( "Verify timeout in #{@verify_timeout}s")
end

Then ("the verify should timeout in $timeout") do |timeout|   
   verify_true(){@verify_timeout.to_f > timeout.to_f}
   verify_true(){@verify_timeout.to_f < timeout.to_f+3}
end


Then ("the verify should timeout with default synchronization value") do
   verify_true(){@verify_timeout.to_f > MobyUtil::Parameter[:synchronization_timeout].to_i}
   verify_true(){@verify_timeout.to_f < MobyUtil::Parameter[:synchronization_timeout].to_i+3}
end

Then ("I call verify_signal to catch signal $signal with no message") do | signal |

    button1  = @sut.application.Button(:objectName => "zeroButton")

    button1.verify_signal(10, signal ){ button1.tap }

end

Then ("I call verify_signal to catch signal $signal with message $msg" )do | signal, msg|

  button1  = @sut.application.Button(:objectName => "zeroButton")

  button1.verify_signal(10, signal, msg){ button1.tap }

end

And("I $status custom on error verify block" ) do | status |

  case status

    when /enable/i
    
      $on_error_verify_block_executed = false

      on_error_verify_block{  $on_error_verify_block_executed = true }

    when /disable/i

        $on_error_verify_block_executed = nil

        reset_on_error_verify_block

  else

  end  
  # set
  # disable

end
   
And("I call $method that $status" ) do | method, status |

      case status

# FAILS
        when /fails/

          begin

            @failed = false

            case method

# VERIFY
              when /^verify$/
                verify( 0, "" ){ raise ArgumentError.new("error") }

# VERIFY_NOT
              when /verify_not/
                verify_not( 0, "" ){ nil }

# VERIFY_TRUE
              when /verify_true/
                verify_true( 0, "" ){ false }

# VERIFY_FALSE
              when /verify_false/
                verify_false( 0, "" ){ true }

# VERIFY_EQUAL
              when /verify_equal/
                verify_equal( "0", 0 ){ 1 }

# VERIFY_SIGNAL
              when /verify_signal/
                button1  = @sut.application.Button(:objectName => "zeroButton")
                button1.verify_signal(0, 'unknownSignal()' )


            else

              raise ArgumentError.new( "invalid verify method" )

            end  

          rescue Exception => exception
      
            # pass
            @failed = true if [ MobyBase::VerificationError ].include?( exception.class )
  
          ensure 

            raise ArgumentError.new( "should have failed" ) unless @failed

          end

# PASSES
        when /passes/

          begin
  
            case method

# VERIFY
              when /^verify$/
                verify( 0, "" ){ nil }

# VERIFY_NOT
              when /verify_not/
                verify_not( 0, "" ){ raise ArgumentError.new("error") }

# VERIFY_TRUE
              when /verify_true/
                verify_true( 0, "" ){ true } 

# VERIFY_FALSE
              when /verify_false/
                verify_false( 0, "" ){ false }

# VERIFY_EQUAL
              when /verify_equal/
                verify_equal( "0", 0 ){ "0" }

# VERIFY_SIGNAL
              when /verify_signal/

		@button  = @sut.application.Button(:objectName => "zeroButton")

		@button.verify_signal(10, 'clicked()' ){

			@button.tap

		}

            else

              raise ArgumentError.new( "invalid verify method" )

            end  

          rescue Exception => exception
      
            raise exception       
  
          end

      else

        raise ArgumentError.new( "invalid status" )

      end

end

Then("user defined code block $status be executed" ) do | status |

  case status

    when /will/
      verify_true( 0, "" ){ $on_error_verify_block_executed == true }

    when /won't/
      verify_true( 0, "" ){ [ false, nil ].include?( $on_error_verify_block_executed ) }

  else

    raise ArgumentError.new( "invalid status" )

  end

  $on_error_verify_block_executed = false

end


