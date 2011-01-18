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

And("I launch testapp for $seconds seconds") do | seconds |
  raise @__exception if @__exception != nil
  $pid = @sut.execute_shell_command("testapp -r "+seconds.to_s, :threaded => "true").to_i
end

Then("the pid should be still running") do 
  raise @__exception if @__exception != nil
  verify_equal("RUNNING") {$obj['status']}      
end
