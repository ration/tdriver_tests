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
*  Name        : gesturehandler.cpp
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

#include "graphicsgesturehandler.h"

GraphicsGestureHandler::GraphicsGestureHandler(QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{
    mGestureHandler.setFlickLimit(5);
    connect(&mGestureHandler, SIGNAL(flick(const GestureDirection&)), this, SLOT(flickOccured(const GestureDirection&)));
}

void GraphicsGestureHandler::flickOccured(const GestureDirection& direction)
{
    emit flick(direction);
}

void GraphicsGestureHandler::setFlickLimit(int flickLimit)
{
    mGestureHandler.setFlickLimit(flickLimit);
}

void GraphicsGestureHandler::mousePressEvent(QGraphicsSceneMouseEvent *event)
{
    update();
    mGestureHandler.handleMousePress(event->scenePos());
    QGraphicsItem::mousePressEvent(event);    
}

void GraphicsGestureHandler::mouseMoveEvent(QGraphicsSceneMouseEvent *event )
{
    update();
    mGestureHandler.handleMouseMove(event->scenePos());
    QGraphicsItem::mouseMoveEvent(event);    
}

void GraphicsGestureHandler::mouseReleaseEvent(QGraphicsSceneMouseEvent *event)
{
    update();
    mGestureHandler.handleMouseRelease(event->scenePos());
    QGraphicsItem::mouseReleaseEvent(event);    
}

