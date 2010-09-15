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

#include "editview.h"

#include <QDebug>
#include <QtGui>
#include <QGraphicsScene>
#include <QWheelEvent>
#include <QTime>
#include <QGraphicsProxyWidget>
#include <QUrl>
#include "control.h"

static const int POPUP_SIZE = 300;

EditView::EditView(const QRectF& rect, QGraphicsItem* parent)
   :BaseView(rect,2, parent)
{
    QDateTimeEdit* dateEdit = new QDateTimeEdit(QDate::currentDate());    
    QGraphicsProxyWidget* proxy = new QGraphicsProxyWidget(this);
    proxy->setWidget(dateEdit);
    proxy->setPos(boundingRect().center());

    Control *launchModal = new Control(this);
    launchModal->setText("A Modal popup");
    launchModal->setObjectName("modalPopup");    
    connect(launchModal, SIGNAL(clicked()), this, SLOT(launchModal()));

    Control *launchNonModal = new Control(this);
    launchNonModal->setText("A Non Modal popup");
    launchNonModal->setObjectName("nonModalPopup");      
    connect(launchNonModal, SIGNAL(clicked()), this, SLOT(launchNonModal()));

    QGraphicsGridLayout *layout = new QGraphicsGridLayout;    
    layout->addItem(launchModal, 0, 0);
    layout->addItem(launchNonModal, 0, 1);
    layout->setColumnMinimumWidth(0, CONTROL_SIZE+5);
    layout->setColumnMinimumWidth(1, CONTROL_SIZE+5);
    layout->setRowMinimumHeight(0, CONTROL_SIZE+5);

    MovableMenu* menu = new MovableMenu(this);    
    menu->setLayout(layout);
    menu->setPos(boundingRect().topLeft());
}

EditView::~EditView()
{
}

void EditView::setWidgets()
{

}

void EditView::launchModal()
{
   PopupItem* item = new PopupItem("A modal dialog...");
   QPointF pos = boundingRect().center();        
   item->setPos(pos-QPointF(POPUP_SIZE/2, POPUP_SIZE/2));
   scene()->addItem(item);
   item->exec();
}

void EditView::launchNonModal()
{
    new PopupItem("A non modal dialog...", this); 
}


MovableMenu::MovableMenu(QGraphicsWidget* parent)
    :QGraphicsWidget(parent)
{
    setFlag(ItemIsMovable);
}

MovableMenu::~MovableMenu()
{
}

QVariant MovableMenu::itemChange(GraphicsItemChange change, const QVariant &value)
{
    if (change == ItemPositionChange && scene()) {
         // value is the new position.
         QPointF newPos = value.toPointF();         
         QRectF rect = scene()->sceneRect();
         if(parentItem()){
             rect = parentItem()->boundingRect();
         }

         if (!rect.contains(newPos)) {
             // Keep the item inside the scene rect.
             newPos.setX(qMin((rect.right() - boundingRect().width()), qMax(newPos.x(), rect.left())));
             newPos.setY(qMin((rect.bottom() - boundingRect().height() - (CONTROL_SIZE+5)), qMax(newPos.y(), rect.top())));
             return newPos;
         }
    }
    return QGraphicsItem::itemChange(change, value);
}

PopupItem::PopupItem(const QString& message, QGraphicsWidget* parent)
    :QGraphicsWidget(parent)
{
    setVisible(false);

    mMessage = message;
    mTimer.setSingleShot(true);
    connect(&mTimer, SIGNAL(timeout()), this, SLOT(closeDialog()));    

    if(parent){
        QPointF pos = parent->boundingRect().center();        
        setPos(pos-QPointF(POPUP_SIZE/2, POPUP_SIZE/2));
        show();
    }

}

PopupItem::~PopupItem()
{}


void PopupItem::exec()
{
    //only allowed when no parent item and added to scene
    if(parentItem() && !scene()){
        return;
    }    
    Background background;
    scene()->addItem(&background);
    show();

    if (scene()) {
        QGraphicsItem *item = scene()->mouseGrabberItem();
        if (item) {
            item->ungrabMouse();
        }
    }

    QEventLoop eventLoop;
    connect(&mTimer, SIGNAL(timeout()), &eventLoop, SLOT(quit()));
    eventLoop.exec(); 
    scene()->removeItem(&background);
    deleteLater();
}
void PopupItem::showEvent(QShowEvent *event)
{
    QGraphicsWidget::showEvent(event);
    mTimer.start(3000);
}


void PopupItem::closeDialog()
{
    close();
    if(parentItem()){
        deleteLater();
    }
}

QRectF PopupItem::boundingRect() const
{
    return QRectF(0, 0, POPUP_SIZE, POPUP_SIZE);
}

QPainterPath PopupItem::shape() const
{
    QPainterPath path;
    path.addRect(0, 0, POPUP_SIZE, POPUP_SIZE);
    return path;
}

void PopupItem::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    painter->setBrush(Qt::red);
    painter->setPen(QPen(Qt::black, 0));
    painter->drawRect(0, 0, POPUP_SIZE, POPUP_SIZE);    
    painter->setFont(font());
    painter->drawText(QRectF(0, 0, POPUP_SIZE, POPUP_SIZE), Qt::AlignVCenter | Qt::AlignHCenter, mMessage); 
}

QString PopupItem::getText()
{
    return mMessage;
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
