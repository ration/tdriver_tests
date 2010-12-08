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

#HEADERS += testabilityinterface.h
SOURCES += main.cpp

target.path = $$TAS_TARGET_BIN

testqml.files = qml/*
testqml.sources = qml/*
testqml.path = $$TAS_TEST_FOLDER/browser/qml

testhtml.files = html/*
testhtml.sources = html/*
testhtml.path = $$TAS_TEST_FOLDER/browser/html

DEPLOYMENT += target testqml testhtml
INSTALLS += target testqml testhtml
