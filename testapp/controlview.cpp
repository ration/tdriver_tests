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
*  Name        : controlview.cpp
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
#include <QDebug>
#include <QtGui>
#include <QGraphicsScene>
#include <QGraphicsGridLayout>

#include "controlview.h"


ControlView::ControlView(QSize size, QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{
    setZValue(2);
    setFlags(ItemClipsChildrenToShape);

    mSize = size;

    quit = new Control(this);
    quit->setObjectName("Quit");
    quit->setText("X");
    connect(quit, SIGNAL(clicked()), qApp, SLOT(quit()));
    quit->setPos(size.width()-(CONTROL_SIZE+5), 0);
    
    controls = new ControlContainer(this);
    //    controls->setPos(size.width()/2-);
}


QRectF ControlView::boundingRect() const
{
     QRectF rect = scene()->sceneRect();
     return QRectF(0,0,mSize.width(), mSize.height());
}

QPainterPath ControlView::shape() const
{    
    QRectF rect = scene()->sceneRect();
    QPainterPath path;
    path.addRect(boundingRect());
    return path;   
}

void ControlView::paint(QPainter *, const QStyleOptionGraphicsItem *, QWidget *)
{
    //painter->setBrush(QBrush(Qt::white));
    //painter->setPen(QPen(Qt::white, 0));
    //painter->drawRect(boundingRect());        
}

ControlContainer::ControlContainer(QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{
}
