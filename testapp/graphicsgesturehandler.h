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
*  Name        : gesturehandler.h
*  Part of     : Test application
*  Description : Test application control view
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

#ifndef GRAPHICSGESTUREHANDLER_H
#define GRAPHICSGESTUREHANDLER_H

#include <QtGui>
#include <QtGui/QGraphicsView>
#include <QGraphicsWidget>
#include <QList>
#include <QGraphicsSceneMouseEvent>
#include <QTime>

//#include "taslogger.h"
#include "gesturehandler.h"


class GraphicsGestureHandler : public QGraphicsWidget
{
    Q_OBJECT

public:  
    GraphicsGestureHandler(QGraphicsItem* parent=0);
    virtual ~GraphicsGestureHandler(){};

	void setFlickLimit(int flickLimit);

signals:
	void flick(const GestureDirection&);

protected slots: 
 	void flickOccured(const GestureDirection&); 

protected:
    void mousePressEvent(QGraphicsSceneMouseEvent *event); 
    void mouseReleaseEvent(QGraphicsSceneMouseEvent *event); 
	void mouseMoveEvent(QGraphicsSceneMouseEvent * event ); 

private:
	GestureHandler mGestureHandler;
	
};

#endif

