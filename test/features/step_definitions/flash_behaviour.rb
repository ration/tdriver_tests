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

Then "I set he mandatory flash parameters for sut" do
  @sut.parameter[:flash_attempts]='1'
  @sut.parameter[:timeout_between_command_sequence]='1'
  @sut.parameter[:switchbox_commands_before_flash]=''
  @sut.parameter[:commands_before_flash]=''
  @sut.parameter[:flash_command]='cucumber --help'
  @sut.parameter[:timeout_before_executing_commands_during_flash]=''
  @sut.parameter[:switchbox_commands_during_flash]=''
  @sut.parameter[:optional_parameters_after_flashing]=''
  @sut.parameter[:flash_images]=''
  @sut.parameter[:sleep_time_after_flash_command]='1'
  @sut.parameter[:command_after_flash]=''
  @sut.parameter[:switchbox_commands_after_failed_flash]=''
  @sut.parameter[:commands_after_failed_flash]=''
  @sut.parameter[:flash_command_success_string]=''
  @sut.parameter[:switchbox_commands_after_flash]=''
end
