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
*  Name        : gesturehandler.h
*  Part of     : Test application
*  Description : Test application control view
*  Version     : %version: %
*
*  Copyright � 2008 Nokia.  All rights reserved.
*  This material, including documentation and any related computer
*  programs, is protected by copyright controlled by Nokia.  All
*  rights are reserved.  Copying, including reproducing, storing,
*  adapting or translating, any or all of this material requires the
*  prior written consent of Nokia.  This material also contains
*  confidential information which may not be disclosed to others
*  without the prior written consent of Nokia.
*  ===========================================================================
*/

#ifndef GESTUREHANDLER_H
#define GESTUREHANDLER_H

#include <QtGui/QGraphicsView>
#include <QGraphicsWidget>
#include <QList>
#include <QGraphicsSceneMouseEvent>
#include <QTime>

//#include "taslogger.h"

enum GestureDirection
{
    UP = 1,
	DOWN,
	LEFT,
	RIGHT
};


class GestureHandler : public QObject
{
    Q_OBJECT

public:  
    GestureHandler(QObject* parent=0);
    ~GestureHandler();

	void setFlickLimit(int flickLimit);

signals:
	void flick(const GestureDirection& direction);
	void rotate(const GestureDirection& direction);

public:
	void handleMousePress(QPointF pos);
	void handleMouseMove(QPointF pos);
	void handleMouseRelease(QPointF pos);

	bool isFlick(GestureDirection& direction);
	void calculateMaxPoints();
	qreal getSmallerAngle(QLineF base, QLineF a, QLineF b);

protected:

	struct MoveEvent{
	  QPointF point;
	  QTime whenOccured;
	};

	QPointF mDownPos;
	QPointF mUpPos;
	QPointF mHighPoint;
	QPointF mLowPoint;
	QPointF mLeftPoint;
	QPointF mRightPoint;
	bool mButtonDown;
	QList<MoveEvent> mTrail;

	int mFlickLimit;
	
};

#endif

