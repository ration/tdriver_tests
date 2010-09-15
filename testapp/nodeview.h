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
*  Name        : nodeview.h
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

#ifndef NODEVIEW_H
#define NODEVIEW_H

#include <QtGui/QGraphicsView>
#include <QGraphicsWidget>

//#include "controlview.h"
#include "baseview.h"

class Node;
class Crasher;

class NodeView : public BaseView
{
    Q_OBJECT
    Q_PROPERTY(int nodeCount READ getNodeCount)
    Q_PROPERTY(int rectangleCount READ getRectangleCount)

public:
    NodeView(const QRectF& rect, QGraphicsItem* parent=0);
    ~NodeView();

	void addTriangle();
 
public slots:
    void addNewNode();
    void addNewRectangle();
    void scramble();
    void resetView();

signals:
	void sizeChange();

protected:
    void keyPressEvent(QKeyEvent *event);
    QPointF randomPos(QRectF area);
    int getNodeCount();
    int getRectangleCount();

private:
    //ControlView* controlView;
    int timerId;
    int nodeCount;
    int rectangleCount;
	int triangleCount;
	Crasher* mCrasher;
};

#endif
