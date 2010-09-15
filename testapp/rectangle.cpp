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
*  Name        : rectangle.cpp
*  Part of     : Test application
*  Description : Test application rectangle
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

#include <QGraphicsScene>
#include <QGraphicsSceneMouseEvent>
#include <QPainter>
#include <QStyleOption>
#include <QDebug>

#include "rectangle.h"

static const int SIZE = 60;

Rectangle::Rectangle(QGraphicsItem* parent)
    :Shape(parent)
{
    setFlag(ItemIsMovable);
    setCacheMode(DeviceCoordinateCache);
    setZValue(2);
}

QRectF Rectangle::boundingRect() const
{
    qreal adjust = 3;
    return QRectF(0,0, SIZE+adjust, SIZE+adjust);
}

QPainterPath Rectangle::shape() const
{
    QPainterPath path;
    path.addRect(0, 0, SIZE, SIZE);
    return path;
}

void Rectangle::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    if (option->state & QStyle::State_Sunken) {
        painter->setBrush(Qt::black);
        colorName = "black";
    }
    else {
        if(itemsOnTop()){
            painter->setBrush(Qt::blue);
            colorName = "blue";
        }
        else{
            painter->setBrush(Qt::red);
            colorName = "red";
        }    
    }
    painter->setPen(QPen(Qt::black, 0));
    painter->drawRect(0, 0, SIZE, SIZE);    
}

bool Rectangle::itemsOnTop()
{
    if(scene()){
        QListIterator<QGraphicsItem*> i(scene()->items(sceneBoundingRect()));
        while (i.hasNext()){
            if(i.next()->type() == NODE_TYPE){
                return true;
            }
        }
    }
    return false;
}

