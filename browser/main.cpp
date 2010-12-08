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
#include "testabilityinterface.h" //this file needs to be copied to inc folder from qttas package
/*Endof adding files */


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    TestabilityInterface* testabilityInterface;

    /* In beginning of main file: activate testailiby plugin if available */
    QString testabilityPlugin = "testability/testability";
    QString testabilityPluginPostfix = ".dll";

#ifdef Q_OS_LINUX
    testabilityPluginPostfix = ".so";
    testabilityPlugin = "testability/libtestability";
#endif

#ifdef Q_WS_MAC
    testabilityPluginPostfix = ".dylib";
    testabilityPlugin = "testability/libtestability";
#endif

    testabilityPlugin = QLibraryInfo::location(QLibraryInfo::PluginsPath)
                        + QObject::tr("/") + testabilityPlugin + testabilityPluginPostfix;
    QPluginLoader loader(testabilityPlugin.toLatin1().data());

    QObject *plugin = loader.instance();
    if (plugin) {
        qDebug("Testability plugin loaded successfully!");
        testabilityInterface = qobject_cast<TestabilityInterface *>(plugin);

        if (testabilityInterface) {
            qDebug("Testability interface obtained!");
            testabilityInterface->Initialize();
        } else {
            qDebug("Failed to get testability interface!");
        }
    } else {
        qDebug("Testability plugin %s load failed with error:%s",
               testabilityPlugin.toLatin1().data(), loader.errorString().toLatin1().data());
    }

    /* Endof activate testailiby plugin if available */

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
