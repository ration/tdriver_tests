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
*  Name        : controlview.h
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

#ifndef CONTROLVIEW_H
#define CONTROLVIEW_H

#include <QtGui/QGraphicsView>
#include <QWidget>
#include <QGraphicsItem>
#include <QBrush>
#include <QSize>

#include "control.h"
#include "controltab.h"

static const int CONTROLVIEW_SIZE = 30;
static const int CONTROLVIEW_ADJUST = 2;

class ControlContainer;

class ControlView : public QGraphicsWidget
{
public:  
    ControlView(QSize size, QGraphicsItem* parent=0);
  
    QRectF boundingRect() const;
	QPainterPath shape() const;	
	void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);

private:
	QSize mSize;
	Control* quit;
	ControlContainer* controls;
};

class ControlContainer : QGraphicsWidget
{
public:
    ControlContainer(QGraphicsItem* parent=0);
};

#endif
