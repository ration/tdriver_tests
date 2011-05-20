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

#include <QGraphicsScene>
#include <QGraphicsSceneMouseEvent>
#include <QPainter>
#include <QStyleOption>
#include <QDebug>

#include "node.h"

static const int SIZE = 40;
static const int ADJUST = 3;

Node::Node(QGraphicsItem* item)
    :Shape(item)
{
    setFlag(ItemIsMovable);
    setCacheMode(DeviceCoordinateCache);
    setZValue(3); 
    setProperty("emptyProp", "");
}

QRectF Node::boundingRect() const
{
    //    return QRectF(0, 0, SIZE + ADJUST, SIZE + ADJUST);
    return QRectF(0, 0, SIZE , SIZE );
}

QPainterPath Node::shape() const
{
    QPainterPath path;
    path.addEllipse(0, 0, SIZE, SIZE);
    return path;
}

void Node::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{    
    if (option->state & QStyle::State_Sunken) {
        painter->setBrush(Qt::yellow);
        colorName = "yellow";
    }
    else{
        painter->setBrush(Qt::green);
        colorName = "green";
    }    

    painter->setPen(QPen(Qt::black, 0));
    painter->drawEllipse(0, 0, SIZE, SIZE);
}



QString Node::color() 
{
    return shapeColor();
}

int Node::sumTest(int x,double y) 
{
    qDebug() << x << "+" << y;
    return (int)(x+y);
}

double Node::doubleTest(double x,double y) 
{
    qDebug() << x << "/" << y;
    return x/y;
}

bool Node::inverse(bool inverse)
{
    return !inverse;
}

