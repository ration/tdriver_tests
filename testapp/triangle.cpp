/*************************************************************************** 
** 
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
** All rights reserved. 
** Contact: Nokia Corporation (testabilitydriver@nokia.com) 
** 
** This file is part of MATTI. 
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

#include <QGraphicsScene>
#include <QGraphicsSceneMouseEvent>
#include <QPainter>
#include <QStyleOption>
#include <QDebug>

#include "triangle.h"

static const int SIZE = 40;
static const int ADJUST = 3;

Triangle::Triangle(QGraphicsItem* item)
    :Shape(item)
{
    mPolygon << QPointF(0, SIZE) << QPointF(SIZE/2, 0) << QPointF(SIZE, SIZE) << QPointF(0, SIZE);
    setFlag(ItemIsMovable);
    setCacheMode(DeviceCoordinateCache);
    setZValue(2); 
    mPressed = false;
}

QRectF Triangle::boundingRect() const
{
    return QRectF(0, 0, SIZE + ADJUST, SIZE + ADJUST);
}

QPainterPath Triangle::shape() const
{
    QPainterPath path;
    path.addPolygon(mPolygon);
    return path;
}

void Triangle::paint(QPainter *painter, const QStyleOptionGraphicsItem*, QWidget *)
{    
    if (!mPressed) {
        painter->setBrush(Qt::magenta);
        colorName = "magenta";
    }
    else{
        painter->setBrush(Qt::darkMagenta);
        colorName = "darkMagenta";
    }    

    painter->setPen(QPen(Qt::black, 0));
    painter->drawPolygon(mPolygon);
}


void Triangle::mousePressEvent(QGraphicsSceneMouseEvent *event)
{    
    mPressed = true;
    update();
    QGraphicsItem::mousePressEvent(event);
}

void Triangle::mouseReleaseEvent(QGraphicsSceneMouseEvent *event)
{
    mPressed = false;
    update();
    QGraphicsItem::mouseReleaseEvent(event);
    emit clicked();
}
