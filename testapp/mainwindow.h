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
*  Name        : main.cpp
*  Part of     : Test application
*  Description : Test application main
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

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

#include "testabilityinterface.h"

#include "nodeview.h"
#include "editview.h"
#include "mainview.h"
#include "webkitview.h"

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget* parent = 0);
    ~MainWindow();
        void addNodes(int amount = 1);
        void setCrashOnExit();
        void setCrashOnStart();

public slots:
        void openMenu();

protected:
        void keyPressEvent(QKeyEvent *event);
        void resizeEvent(QResizeEvent * event);

protected slots:
        void flickScreen(const GestureDirection&);

private:
        void createToolBar();
        void loadPlugin();
        void addControls();
        void determineSize();

private:
  MainView* mainView;
  NodeView* view;
  EditView* editView;
  BaseView* currentView;
  WebKitView* webkitView;
  QGraphicsScene* scene;
  QToolBar* toolBar;
  TestabilityInterface* testabilityInterface;
  bool mInitialized;
  QSizeF mViewSize;
  bool mFullScreen;
  QPoint mCurrPos; // Current position of the flicked screen
  static const int VIEWS = 3;
};

class Crasher : public QObject
{
  Q_OBJECT
public slots:
  void crash();
};

#endif
