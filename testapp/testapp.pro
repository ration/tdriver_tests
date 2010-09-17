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


TARGET = testapp
DESTDIR = bin
#CONFIG += release

include(../tasbase.pri)


#for mac use "qmake -spec macx-g++" to avoid xcode files

mac {
   CONFIG -= app_bundle
}

symbian {
    TARGET.CAPABILITY=CAP_APPLICATION
    TARGET.EPOCHEAPSIZE = 0x100000 0x2000000 # Min 128kb, Max 16Mb
}

HEADERS += \
        node.h \
        triangle.h \
        mainwindow.h \
        nodeview.h \
        controlview.h \
        rectangle.h \
        shape.h \
        gesturehandler.h \
        mainview.h \
        baseview.h \
        controltab.h \
        editview.h \
        control.h \
        graphicsgesturehandler.h \
        testabilityinterface.h \
        tasapplication.h \
        webkitview.h \
        testpage.h


SOURCES += \
        main.cpp \
        node.cpp \
        triangle.cpp \
        mainwindow.cpp \
        shape.cpp \
        rectangle.cpp \
        nodeview.cpp \
        controlview.cpp \
        gesturehandler.cpp \
        mainview.cpp \
        baseview.cpp \
        controltab.cpp \
        editview.cpp \
        graphicsgesturehandler.cpp \
        control.cpp \
        tasapplication.cpp \
        webkitview.cpp


# install
unix:{
   DESTDIR = bin
   target.path = $$TAS_TARGET_BIN
   testdata.files = testdata/*
   testdata.path = /etc/tdriver/testdata
   testrunner.files = testrunner/calculator_runner.sh
   testrunner.path = /usr/bin
}

macx:{
  target.path = /usr/local/bin
}

win32:{
  target.path = /qttas/bin
  testdata.files = testdata/*
  testdata.path = /tdriver/testdata
  testrunner.files = testrunner/runner.bat
  testrunner.path = /qttas/bin
}

INSTALLS += target testdata testrunner
# removed until maemo ci has webkit properly installed
QT += webkit

#QMAKE_CXXFLAGS=
