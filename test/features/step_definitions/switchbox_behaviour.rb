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


# Common step definitions to be used in feature testing of TDriver
# Author: Mika Leiman
# Date: 24.9.2010
# Purpose: Steps used to test flaxi behaviour


require 'tdriver'
include TDriverVerify

Then "I set the mandatory switchbox parameters for sut" do
  @sut.parameter[:switchbox_sleep_before_powerup_in_reboot]='1'
  @sut.parameter[:switchbox_sleep_after_powerup_in_reboot]='1'
  #@sut.parameter[:switchbox_powerdown_command_sequence]='cucumber --help|cucumber -h'
  #@sut.parameter[:switchbox_powerup_command_sequence]='cucumber -h|cucumber --help'

  @sut.parameter[:switchbox_powerdown_command_sequence]='ruby -v|ruby -v'
  @sut.parameter[:switchbox_powerup_command_sequence]='ruby -v|ruby -v'

  @sut.parameter[:switchbox_timeout_between_command_sequence]='1'
  @sut.parameter[:switchbox_powerdown_command_success_string]='true'
  @sut.parameter[:switchbox_powerup_command_success_string]='true'
  #@sut.parameter[:switchbox_commands_after_powerup_in_reboot]='cucumber --help'

  @sut.parameter[:switchbox_commands_after_powerup_in_reboot]='ruby -v'

end

Then "The power status is $power_status" do |power_status|
  verify_true(0,"Power status should have been #{power_status}"){@power_status.to_s==power_status}
end
