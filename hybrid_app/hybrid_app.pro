######################################################################
# Automatically generated by qmake (2.01a) Fri 17. Dec 12:52:15 2010
######################################################################

TEMPLATE = app
TARGET = hybrid_app
DEPENDPATH += .
INCLUDEPATH += .

symbian {
    TARGET.CAPABILITY=ALL -TCB
	TARGET.VID = VID_DEFAULT
  	TARGET.EPOCALLOWDLLDATA = 1 
}


# Input
SOURCES += main.cpp

QT += declarative

RESOURCES += hybrid_app.qrc

# install
unix:{
target.path = /usr/bin
}
win32:{
target.path = /qttas/bin
}
INSTALLS += target
