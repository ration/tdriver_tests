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


TARGET = matti_multitouchapp
DESTDIR = bin

#for mac use "qmake -spec macx-g++" to avoid xcode files

mac {
   CONFIG -= app_bundle
}

symbian {
    TARGET.CAPABILITY=CAP_APPLICATION
}

HEADERS += \
	    popupmenu.h \
	    mainwindow.h 

SOURCES += \
        main.cpp \
        popupmenu.cpp \
        mainwindow.cpp 


# install
unix:{
   DESTDIR = bin
   target.path = /usr/bin
}

macx:{
	target.path = /usr/local/bin
}

win32:{
	target.path = \qttas\bin
	testdata.files = testdata\*
	testdata.path = \Matti\testdata
}

INSTALLS += target 

#QMAKE_CXXFLAGS=
