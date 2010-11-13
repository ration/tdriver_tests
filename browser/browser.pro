#-------------------------------------------------
#
# Project created by QtCreator 2010-11-12T17:44:04
#
#-------------------------------------------------


include(../tasbase.pri)

QT       += core gui declarative

TARGET = browser
TEMPLATE = app
DESTDIR = bin

SOURCES += main.cpp

unix:{
   target.path = $$TAS_TARGET_BIN
   testqml.files = qml/*
   testqml.path = $$TAS_TEST_FOLDER/browser/qml
   testhtml.files = html/*
   testhtml.path = $$TAS_TEST_FOLDER/browser/html
}
INSTALLS += target testqml testhtml
