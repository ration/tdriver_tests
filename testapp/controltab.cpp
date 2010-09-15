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
#include <QLinearGradient>

#include "controltab.h"

static const int startAngle = 30 * 16;
static const int spanAngle = 120 * 16;



ControlTab::ControlTab(QGraphicsItem* parent)
    :GraphicsGestureHandler(parent)
{
    setFlag(ItemIsSelectable);
    setCacheMode(DeviceCoordinateCache);
    setZValue(4);
}

QRectF ControlTab::boundingRect() const
{
    return QRectF(0, 0, CONTROLTAB_WIDTH+3, CONTROLTAB_HEIGHT+3);
}

QPainterPath ControlTab::shape() const
{
    QPainterPath path;
    path.arcTo(QRectF(0, 0, CONTROLTAB_WIDTH, CONTROLTAB_WIDTH), startAngle, spanAngle);
    return path;
}

void ControlTab::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{    
    if (option->state & QStyle::State_Sunken) {
        painter->setBrush(QBrush(Qt::cyan));
    }
    else{
        painter->setBrush(QBrush(Qt::darkCyan));
    }   
    painter->setPen(QPen(Qt::black, 2));
    painter->drawChord(QRectF(0, 0, CONTROLTAB_WIDTH, CONTROLTAB_WIDTH), startAngle, spanAngle);
}
