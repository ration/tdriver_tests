/***************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (testabilitydriver@nokia.com)
**
** This file is part of TDriver.
**
** If you have questions regarding the use of this file, please contact
** Nokia at testabilitydriver@nokia.com .
**
** This library is free software; you can redistribute it and/or
** modify it under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation
** and appearing in the file LICENSE.LGPL included in the packaging
** of this file.
**
****************************************************************************/

#include <QObject>
#include <QString>

#include <QtGui/QApplication>
#include <QDeclarativeView>
#include <QApplication>
#include <QFile>

/*Add following libraries to enable testabilityloading and testailiby if not already included */
#include <QtPlugin>
#include <QPluginLoader>
#include <QLibraryInfo>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setApplicationName("Matti HybridApp");

#if !defined(QT_NO_LIBRARY)

    QLibrary testLib("qttestability");
    if(testLib.load()){
        typedef void (*TasInitialize)(void);
        TasInitialize initFunction = (TasInitialize)testLib.resolve("qt_testability_init");
#ifdef Q_OS_SYMBIAN
        //not found so use ordinal
        if(!initFunction){
            initFunction = (TasInitialize)testLib.resolve("1");
        }
#endif
        if(initFunction){
            initFunction();
        }
    }
#endif

    QDeclarativeView view;
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}
