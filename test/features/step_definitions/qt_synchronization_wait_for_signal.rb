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


And "I listen for signal clicked() from button \"$button_name\" using fixture" do |$button_name|
  #puts @__sut.application.Button(:name =>'oneButton').fixture('signal', 'list_signals')
  @__sut.application.Button(:name => $button_name.to_s).fixture('signal','enable_signal', {:signal => 'clicked()'})
end