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
*  Name        : nodeview.cpp
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

#include <QApplication>

#include "baseview.h"
#include "controltab.h" 
#include "shape.h"

BaseView::BaseView(const QRectF& rect,  int controlCols, QGraphicsItem* parent)
   :GraphicsGestureHandler(parent)
{
    mControlCols = controlCols;
    mControlCount = 0;
    mCrash = 0;
    mSceneRect = rect;
    setLayoutDirection(Qt::RightToLeft);
    controls = new Menu(mSceneRect, this);
    controls->setObjectName("FloatingMenu");
    controls->setVisible(false);
    //controls->setFlag(ItemIsMovable);
    layout = new QGraphicsGridLayout;
    ControlTab* menuTab = new ControlTab(this);
    menuTab->setObjectName("ControlTab");
    layout->addItem(menuTab, 0, 0, 1, mControlCols, Qt::AlignCenter);
    layout->setRowMinimumHeight(0, CONTROLTAB_HEIGHT);
    //connect(menuTab, SIGNAL(clicked()), this, SLOT(toggleMenu()));    
    connect(menuTab, SIGNAL(flick(const GestureDirection&)), this, SLOT(flickMenu(const GestureDirection&)));    
    
    controls->setLayout(layout);

    setFlags(ItemClipsChildrenToShape);
    setFlag(ItemIsSelectable);

    mQuit  = new Control(this);
    mQuit->setObjectName("Quit");
    mQuit->setText("Quit");
    mQuit->setZValue(1); 
    connect(mQuit, SIGNAL(clicked()), this, SLOT(quit()));
    setQuitButton();
       
    setFlickLimit(50);
    update();
}

QRectF BaseView::boundingRect() const
{
    return mSceneRect;
}

void BaseView::quit()
{
    qApp->quit();
}

void BaseView::flickMenu(const GestureDirection& direction)
{
    if(direction == UP && !controls->isActive()){
        controls->activate();
    }
    else if(direction == DOWN && controls->isActive()){
        controls->hide();
    }

}

QPainterPath BaseView::shape() const
{
    QPainterPath path;
    path.addRect(mSceneRect);
    return path;
}

void BaseView::sizeChanged(QRectF newSceneRect)
{
    mSceneRect = newSceneRect;
    setQuitButton();
    setCrashButton();
    controls->sizeChanged(newSceneRect);
    update();
}

void BaseView::setQuitButton()
{
    QPointF quitPos = mSceneRect.topRight();
    //quitPos.setX(quitPos.x()-(CONTROL_SIZE));
    quitPos.setX(quitPos.x()-mQuit->boundingRect().width());
    mQuit->setPos(quitPos);
}

void BaseView::setCrashButton()
{
    QPointF quitPos = mSceneRect.topLeft();
    if(mCrash)
        mCrash->setPos(quitPos);
}

void BaseView::paint(QPainter *painter, const QStyleOptionGraphicsItem */*option*/, QWidget *)
{
    painter->setBrush(Qt::white);
    painter->setPen(QPen(Qt::white, 0));
    painter->drawRect(mSceneRect);
}

Control* BaseView::addNewControl(const QString& name, const QString& text)
{
    Control* control = new Control(this);
    control->setObjectName(name);
    control->setText(text);
    int row = layout->rowCount() -1 ;
    if(mControlCount == mControlCols){
        mControlCount = 0;
        row++;
        controls->hide();        
    }

    if(row == 0){
        row++;        
    }
    
    layout->addItem(control, row, mControlCount);
    layout->setColumnMinimumWidth(mControlCount, CONTROL_SIZE+5);
    layout->setRowMinimumHeight(row, CONTROL_SIZE+5);
    mControlCount++;

    return control;
}

Menu::Menu(const QRectF& rect, QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{
    mSceneRect = rect;
    setZValue(4); 
}
	
bool Menu::isActive()
{
    return mIsMenuActive;
}

void Menu::setActive(bool isActive)
{
    mIsMenuActive = isActive;
}

void Menu::activate()
{
    qreal x = (mSceneRect.width()/2) - (size().width()/2);
    qreal y = mSceneRect.height() - sceneBoundingRect().height();
    setPos(x,y);    
    setActive(true);
}

void Menu::hide()
{
    if(childItems().count() <= 1){
        setVisible(false);
    }
    else{
        setVisible(true);
        qreal x = (mSceneRect.width()/2) - (size().width()/2);
        qreal y = mSceneRect.height()-CONTROLTAB_HEIGHT-5;
        setPos(x,y);
    }
    setActive(false);
}

void Menu::sizeChanged(QRectF newSceneRect)
{
    mSceneRect = newSceneRect;
    if(isActive()){
        activate();
    }
    else{
        hide();
    }
}

