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
 
 
/*
*  ===========================================================================
*  Name        : mainwindow.cpp
*  Part of     : Test application
*  Description : Test application main window
*  Version     : %version: %
*
*  Copyright © 2008 Nokia.  All rights reserved.
*  This material, including documentation and any related computer
*  programs, is protected by copyright controlled by Nokia.  All
*  rights are reserved.  Copying, including reproducing, storing,
*  adapting or translating, any or all of this material requires the
*  prior written consent of Nokia.  This material also contains
*  confidential information which may not be disclosed to others
*  without the prior written consent of Nokia.
*  ===========================================================================
*/

#include "mainwindow.h"

#include <QDebug>
#include <QtGui>
#include <QtPlugin> 
#include <QPluginLoader>
#include <QLibraryInfo>
#include <QGraphicsGridLayout>


MainWindow::MainWindow(QWidget* parent)
    :QMainWindow(parent) 
{
    mInitialized = false;

    scene = new QGraphicsScene(this);
    scene->setItemIndexMethod(QGraphicsScene::NoIndex);
    
    mFullScreen = false;
    determineSize();

    mainView = new MainView(scene);
    mainView->setObjectName("MainView");


    view = new NodeView(QRectF(QPointF(0, 0), mViewSize));
    view->setObjectName("NodeArea");
    scene->addItem(view);
    view->addNewNode();
    view->addTriangle();
    connect(view, SIGNAL(flick(const GestureDirection&)), this, SLOT(flickScreen(const GestureDirection&)));
    
    currentView = view;

    editView = new EditView(QRectF(QPointF(mViewSize.width(), 0), mViewSize));
    editView->setObjectName("EditArea");
    scene->addItem(editView);
    connect(editView, SIGNAL(flick(const GestureDirection&)), this, SLOT(flickScreen(const GestureDirection&)));

    //crashed on exit for some reason, taken out for now in symbian
    webkitView = new WebKitView(QRectF(QPointF(mViewSize.width()*2, 0), mViewSize));
    webkitView->setObjectName("WebKitArea");
    scene->addItem(webkitView);
    connect(webkitView, SIGNAL(flick(const GestureDirection&)), this, SLOT(flickScreen(const GestureDirection&)));

    mainView->centerOn(currentView->boundingRect().center());

    testabilityInterface = 0;

    setCentralWidget(mainView);    
    setObjectName("MainWindow");
    setWindowTitle(tr("Test application"));
    //loadPlugin();
    mInitialized = true;
}

MainWindow::~MainWindow()
{
    if (testabilityInterface) {
        delete testabilityInterface;
    } 
}

void MainWindow::addNodes(int amount)
{
    for(int i = 0 ; i < amount; i++){
        view->addNewNode();
    }
}

void MainWindow::openMenu()
{
    view->flickMenu(UP);
}

void MainWindow::determineSize()
{
    QRect rect = qApp->desktop()->screenGeometry();    
    if(rect.width() > 864 && !mFullScreen ){
        qDebug("MainWindow::determineSize() not full screen");
        setMinimumSize(864, 480);
        setMaximumSize(864, 480);
    }
    else{
        qDebug("MainWindow::determineSize() is full screen");
        setMinimumSize(rect.size());
        setMaximumSize(rect.size());
#ifdef Q_OS_SYMBIAN
        showFullScreen();
#else
        // maemo devices in dui do not like showFullScreen calls, causes an infinite resizeEvent loop.
        showMaximized();
#endif

    }
    mViewSize = minimumSize() - QSize(4,4);
    scene->setSceneRect(0, 0, VIEWS*minimumSize().width(), minimumSize().height());
}


void MainWindow::flickScreen(const GestureDirection& direction)
{
    
    // TasLogger::logger()->debug("MainWindow::flickScreen");
    switch(direction)
    {
    case UP:
    case DOWN:
        break;
    case LEFT:
        if(currentView == view){
            currentView = editView;
        }
        else{
            currentView = webkitView;
        }
        break;
    case RIGHT:
        if(currentView == webkitView){
            currentView = editView;
        }
        else{
            currentView = view;
        }
        break;
    }
    mainView->centerOn(currentView->boundingRect().center());
}

void MainWindow::keyPressEvent(QKeyEvent *event)
{
    
    switch (event->key()) {
    case Qt::Key_F:
        if(event->modifiers() & Qt::ControlModifier){
            mFullScreen = true;
            determineSize();
            showFullScreen();
        }
        break;
    case Qt::Key_Escape:
        mFullScreen = false;
        determineSize();
        showNormal();
        break;
    default:
        QMainWindow::keyPressEvent(event);
    }
}

void MainWindow::resizeEvent(QResizeEvent * event)
{
    determineSize();
    if(mInitialized){
        view->sizeChanged(QRectF(QPointF(0, 0), mViewSize));    
        view->scramble();

        editView->sizeChanged(QRectF(QPointF(mViewSize.width(), 0),  mViewSize));        
        editView->setWidgets();

#if !defined(Q_OS_SYMBIAN)
        webkitView->sizeChanged(QRectF(QPointF(mViewSize.width()*2, 0),  mViewSize));        
        webkitView->setWidgets();
#endif
    }
    QMainWindow::resizeEvent(event);
}


void MainWindow::loadPlugin()
{
    QString testabilityPlugin = "testability/testability";
    QString testabilityPluginPostfix = ".dll";
    
#ifdef Q_OS_LINUX
    testabilityPluginPostfix = ".so";
    testabilityPlugin = "testability/libtestability";
#endif //linux

#ifdef Q_WS_MAC 
    testabilityPluginPostfix = ".dylib";
    testabilityPlugin = "testability/libtestability";
#endif //mac
    
    testabilityPlugin = QLibraryInfo::location(QLibraryInfo::PluginsPath) + QObject::tr("/") + testabilityPlugin + testabilityPluginPostfix;        

#ifdef Q_OS_SYMBIAN

    //TEMPORARY workaround:
    //there is a defect in s60 qt port so that it does not search for plugins 
    //from all possible drives, so check for existence before loading the plugin
    //issue has been reported to port team and they will fix it at some point
    QString flashDrive = "C:";
    QString romDrive = "Z:";   

    //add drive letter to plugin path and then check c and z for the plugin
    if(!testabilityPlugin.startsWith(flashDrive,Qt::CaseInsensitive) && !testabilityPlugin.startsWith(romDrive,Qt::CaseInsensitive)){
        testabilityPlugin = flashDrive + testabilityPlugin; 
    }

    QPluginLoader loader(testabilityPlugin.toLatin1().data());
        
    QObject *plugin = loader.instance();

    if(!plugin){
        if(testabilityPlugin.startsWith(flashDrive,Qt::CaseInsensitive)){
            testabilityPlugin.replace(flashDrive, romDrive, Qt::CaseInsensitive);
        }        
        else{
            testabilityPlugin.replace(romDrive, flashDrive, Qt::CaseInsensitive);

        }
        loader.setFileName(testabilityPlugin.toLatin1().data());
        plugin = loader.instance(); 
    }
    //if the file is in neither then let failure occur similarly as with other platforms

#else    
    QPluginLoader loader(testabilityPlugin.toLatin1().data());
    QObject *plugin = loader.instance();
#endif        

    if (plugin) {
      testabilityInterface = qobject_cast<TestabilityInterface *>(plugin);      
      if (testabilityInterface) {
          testabilityInterface->Initialize();
      } 
    }
}

void MainWindow::setCrashOnExit()
{
    Crasher* crash = new Crasher();
    connect(qApp, SIGNAL(aboutToQuit()), crash, SLOT(crash()));
}

void MainWindow::setCrashOnStart()
{
    Crasher* crash = new Crasher();
    crash->crash();
}

void Crasher::crash()
{
    QObject* madCrashingNullPointer = 0;
    madCrashingNullPointer->setObjectName("Crash");
}
