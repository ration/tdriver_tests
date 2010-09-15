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


TEMPLATE = subdirs

include(tasbase.pri)

SUBDIRS += calculator

SUBDIRS += testapp

SUBDIRS += multitouch

unix: { 
   tests.files = test/*
   tests.path = /usr/share/testability-driver-tests

   unit_tests.files = test/tc_testapp/*
   unit_tests.path = /usr/share/testability-driver-unit-tests

   cita.files = cita/features/tests.xml
   cita.path = /usr/share/testability-driver-tests/

   cita_unit.files = cita/unit/tests.xml
   cita_unit.path = /usr/share/testability-driver-unit-tests/


   INSTALLS += tests cita cita_unit unit_tests
}

