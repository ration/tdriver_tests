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

#include "gesturehandler.h"

//static int MAX_ANGLE = 40;
static int FLICK_ADJUSTMENT = 30;


GestureHandler::GestureHandler(QObject* parent)
    :QObject(parent)
{}

GestureHandler::~GestureHandler()
{
    mTrail.clear();
}

void GestureHandler::setFlickLimit(int flickLimit)
{
    mFlickLimit = flickLimit;
}

bool GestureHandler::isFlick(GestureDirection& direction)
{
    //    TasLogger::logger()->debug("GestureHandler::isFlick");
    //1. difference between start and end must be 100 
    QPointF difference = mDownPos - mUpPos;
    QLineF distance(mDownPos,mUpPos);
    if(distance.length() < mFlickLimit){
        return false;
    }
    if(distance.dx() == distance.dy()){
        return false;
    }
    if(qAbs(distance.dx()) > qAbs(distance.dy())){
        if(mDownPos.x() < mUpPos.x()){
            direction = RIGHT;
        }
        else{
            direction = LEFT;
        }
    }
    else{
        if(mDownPos.y() < mUpPos.y()){
            direction = DOWN;
        }
        else{
            direction = UP;
        }
    }
    //check that this is a flick 
    switch(direction)
        {
        case UP:
        case DOWN:
            if( (mLeftPoint.x() < mDownPos.x()-FLICK_ADJUSTMENT && mLeftPoint.x() < mUpPos.x()-FLICK_ADJUSTMENT) || 
                (mRightPoint.x() > mDownPos.x()+FLICK_ADJUSTMENT &&  mRightPoint.x() > mUpPos.x()+FLICK_ADJUSTMENT) ){
                return false;
            }
            break;
        case LEFT:
        case RIGHT:
            if( (mHighPoint.y() < mDownPos.y()-FLICK_ADJUSTMENT &&  mHighPoint.y() < mUpPos.y()-FLICK_ADJUSTMENT) || 
                (mLowPoint.y() > mDownPos.y()+FLICK_ADJUSTMENT &&  mLowPoint.y() > mUpPos.y()+FLICK_ADJUSTMENT) ){
                return false;
            }
            break;
        }
    return true;
}

qreal GestureHandler::getSmallerAngle(QLineF base, QLineF a, QLineF b)
{
    qreal anglea;
    qreal angleb;

    if(a.x2() > base.x2()){
        anglea = qAbs(a.angleTo(base));
    }
    else{
        anglea = qAbs(base.angleTo(a));
    }
    if(b.x2() > base.x2()){
        angleb = qAbs(b.angleTo(base));
    }
    else{
        angleb = qAbs(base.angleTo(b));
    }
    if(anglea < angleb){
        return anglea;
    }
    else{
        return angleb;
    }
}

void GestureHandler::calculateMaxPoints()
{
    mHighPoint = mDownPos;
	mLowPoint = mDownPos;
	mLeftPoint = mDownPos;
	mRightPoint = mDownPos;
    QListIterator<MoveEvent> i(mTrail);
    while (i.hasNext()){
        MoveEvent event = i.next();
        QPointF point = event.point;
        if(point.y() > mHighPoint.y()){
            mHighPoint = point;
        }
        if(point.y() < mLowPoint.y()){
            mLowPoint = point;
        }
        if(point.x() < mLeftPoint.x()){
            mLeftPoint = point;
        }
        if(point.x() > mRightPoint.x()){
            mRightPoint = point;
        }
    }
}

void GestureHandler::handleMousePress(QPointF pos)
{
    mDownPos = pos;
    mButtonDown = true;
}

void GestureHandler::handleMouseMove(QPointF pos)
{
    if(mButtonDown){
        MoveEvent newEvent;
        newEvent.point = pos;
        newEvent.whenOccured = QTime::currentTime();
        mTrail.append(newEvent);
    }
}

void GestureHandler::handleMouseRelease(QPointF pos)
{
    mUpPos = pos;
    calculateMaxPoints();
    GestureDirection direction;
    if(isFlick(direction)){
        emit flick(direction);
    }
    mButtonDown = false;
    mTrail.clear();
    mDownPos = QPointF(0,0);
    mUpPos = QPointF(0,0);
}
