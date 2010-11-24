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


#include <QtGui/QApplication>
#include <QDeclarativeView>
#include <QApplication>
#include <QFile>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QDeclarativeView view;
    QFile file("../qml/browser.qml");
    QUrl url;
    if(file.exists()){
       //to run correct files without install
       url = QUrl::fromLocalFile("../qml/browser.qml");
    } else {
       //install path
#ifdef Q_OS_LINUX
       url = QUrl::fromLocalFile("/etc/tdriver/testdata/browser/qml/browser.qml");
#else
       url = QUrl::fromLocalFile("/tdriver/testdata/browser/qml/browser.qml");
#endif //Q_OS_LINUX
    }
    view.setSource(url);
#ifdef Q_OS_SYMBIAN
    view.showFullScreen();
#else
    view.show();
#endif //Q_OS_SYMBIAN
    return app.exec();
}
