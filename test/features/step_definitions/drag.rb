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


# The testapp application example must be compiled and in PATH for this test to work
# sut_qt1, sut_qt2, sut_qt3 and sut_qt4 suts must be defined in tdriver_parameters.xml
# /tdriver/Tutorials/QT/application_examples/calculator/release
# Author: Mika Leiman
# Date: 15.5.2009
# Purpose: Tests TDriver Qt methods


require 'tdriver'
include TDriverVerify

Before do
	$ErrorMessage=""
end
