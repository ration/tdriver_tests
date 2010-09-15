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
*  Name        : nodeview.h
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

#ifndef BASEVIEW_H
#define BASEVIEW_H

#include <QtGui/QGraphicsView>
#include <QGraphicsWidget>
#include <QGraphicsGridLayout>

#include "control.h"
#include "graphicsgesturehandler.h"

class Menu;

class BaseView : public GraphicsGestureHandler
{
    Q_OBJECT

public:
    BaseView(const QRectF& sceneRect, int controlCols = 2, QGraphicsItem* parent=0);
    virtual ~BaseView(){};

    QRectF boundingRect() const;
    QPainterPath shape() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);

public slots:
    void sizeChanged(QRectF newSceneRect);
    void quit();
    void flickMenu(const GestureDirection& direction);

protected:
    Control* addNewControl(const QString& name, const QString& text);

protected:
	void setQuitButton();
    void setCrashButton();

protected:
    QRectF mSceneRect;
    Menu* controls;
    Control* mQuit;
    Control* mCrash;
    QGraphicsGridLayout *layout;
    int mControlCols;
    int mControlCount;
    bool mMenuActive;
};

class Menu : public QGraphicsWidget
{
    Q_OBJECT
    Q_PROPERTY(bool isActive READ isActive)

public:

    Menu(const QRectF& rect, QGraphicsItem* parent=0);
	
	bool isActive();
	void setActive(bool isActive);

public slots:
	void activate();
	void hide();
    void sizeChanged(QRectF newSceneRect);

private: 
    QRectF mSceneRect;
	bool mIsMenuActive;
};

#endif
