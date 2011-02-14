#!/usr/bin/env ruby
############################################################################
## 
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
## All rights reserved. 
## Contact: Nokia Corporation (testabilitydriver@nokia.com) 
## 
## This file is part of MATTI. 
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

require 'tdriver_test_suite'

ENV['TDRIVER_BENCHMARK'] = "true"

TDriverTestSuite::EnduranceRunner.add_file( 'tests/tc*.rb') 

TDriverTestSuite::EnduranceRunner.execute( :time => '09:00:00' ) #:times => 1 ) # execute suite only one time

MobyUtil::Hooking.instance.print_benchmark( :sort => :name, :show_uncalled_methods => true )

=begin

# execute suite 10 times
TDriverTestSuite::EnduranceRunner.execute( :times => 10 )

# runtime until midnight of 1.1.2012
TDriverTestSuite::EnduranceRunner.execute( :date => '1.1.2012' )

# runtime until next 08:00:00 (today / tomorrow)
TDriverTestSuite::EnduranceRunner.execute( :time => '08:00:00' )

# execute until 1.1.2009 @ 08:00:00
TDriverTestSuite::EnduranceRunner.execute( :date => '1.1.2009', :time => '08:00:00' )

# runtime: +3 days from current time
TDriverTestSuite::EnduranceRunner.execute( :days => 3 )

# runtime: +5 hours from current time
TDriverTestSuite::EnduranceRunner.execute( :hours => 5 )

# runtime: +10 minutes from current time
TDriverTestSuite::EnduranceRunner.execute( :minutes => 10 )

# runtime: +15 seconds from current time
TDriverTestSuite::EnduranceRunner.execute( :seconds => 15 )

# runtime: +3 days, +5 hours, +10 minutes and +15 seconds from current time
TDriverTestSuite::EnduranceRunner.execute( :days => 3, :hours => 5, :minutes => 10, :seconds => 15 ) 

=end

