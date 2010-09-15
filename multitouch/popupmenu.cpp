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
 
 
#include <QDebug>
#include <QtGui>
#include <QGraphicsScene>
#include <QTime>
#include <QGraphicsGridLayout>

#include "popupmenu.h"

static const int CONTROL_SIZE = 50;

PopupMenu::PopupMenu(const QRectF& vieportArea)
    :QGraphicsWidget()
{
    setVisible(false);
    mTimer.setSingleShot(true);
    connect(&mTimer, SIGNAL(timeout()), this, SLOT(closeDialog()));    
    mRect = vieportArea;
}

PopupMenu::~PopupMenu()
{}


void PopupMenu::exec()
{
    //only allowed when no parent item and added to scene
    if(parentItem() && !scene()){
        return;
    }    
    Background background;
    scene()->addItem(&background);
    background.setZValue(1);
    setZValue(2);
    show();

    QGraphicsItem *item = scene()->mouseGrabberItem();
    if (item) {
        item->ungrabMouse();
    }

    MenuButton* close = new MenuButton(QRectF(0,0,mRect.width()/2,CONTROL_SIZE),Qt::red, Qt::darkRed, this); 
    close->setObjectName("close");
    connect(close, SIGNAL(clicked()), qApp, SLOT(quit()));
    
    MenuButton* next = new MenuButton(QRectF(0,0,mRect.width()/2,CONTROL_SIZE), Qt::blue, Qt::darkBlue, this); 
    next->setObjectName("changeView");
    connect(next, SIGNAL(clicked()), this, SIGNAL(nextView()));

    QPointF pos = mRect.topRight();
    pos.setX(pos.x() - close->boundingRect().width());
    close->setPos(pos);
    next->setPos(mRect.topLeft());

    QEventLoop eventLoop;
    connect(&mTimer, SIGNAL(timeout()), &eventLoop, SLOT(quit()));
    connect(next, SIGNAL(clicked()), &eventLoop, SLOT(quit()));
    eventLoop.exec(); 
    scene()->removeItem(&background);
    deleteLater();
}
void PopupMenu::showEvent(QShowEvent *event)
{
    QGraphicsWidget::showEvent(event);
    mTimer.start(3000);
}


void PopupMenu::closeDialog()
{
    close();
    if(parentItem()){
        deleteLater();
    }
}

Background::Background(QGraphicsWidget* parent)
    :QGraphicsWidget(parent)
{
    setFlag(QGraphicsItem::ItemIsFocusable);
#if QT_VERSION >= 0x040600
    setFlag(QGraphicsItem::ItemHasNoContents, true);
#endif
    setVisible(true);
    setPos(0,0);
}

Background::~Background()
{}
  
QRectF Background::boundingRect() const
{
    return scene()->sceneRect();
}

bool Background::sceneEvent(QEvent *event)
{
    event->accept();
    return true;
}


void Background::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget )
{
    Q_UNUSED(option);
    Q_UNUSED(widget);
    Q_UNUSED(painter);
}

QPainterPath Background::shape() const
{
    QPainterPath path;
    path.addRect(boundingRect());
    return path;
}

MenuButton::MenuButton(QRectF rect, Qt::GlobalColor colorOne, Qt::GlobalColor colorTwo, QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{
    //    setAcceptTouchEvents(true);
    setFlag(ItemIsSelectable);
    mColorOne = colorOne;
    mColorTwo = colorTwo;
    mRect = rect;
}

QRectF MenuButton::boundingRect() const
{
    return mRect;
}

QPainterPath MenuButton::shape() const
{
    QPainterPath path;
    path.addRect(mRect);
    return path;
}

void MenuButton::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    if (option->state & QStyle::State_Sunken) {
         painter->setBrush(QBrush(mColorTwo));
    }
    else{
        painter->setBrush(QBrush(mColorOne));
    }   
    painter->drawRect(boundingRect());
    painter->setPen(QPen(Qt::white));
}

void MenuButton::mouseReleaseEvent(QGraphicsSceneMouseEvent *event)
{
    emit clicked();
}
