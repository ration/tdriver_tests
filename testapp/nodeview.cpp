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
*  Name        : nodeview.cpp
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

#include "nodeview.h"
#include "controlview.h"
#include "node.h"
#include "triangle.h"
#include "shape.h"
#include "rectangle.h"

#include <QDebug>
#include <QtGui>
#include <QGraphicsScene>
#include <QWheelEvent>
#include <QTime>

#include <math.h>

#include <QtPlugin> 
#include <QPluginLoader>
#include <QLibraryInfo>

#include "control.h"
#include "controltab.h"
#include "mainwindow.h"

NodeView::NodeView(const QRectF& rect, QGraphicsItem* parent)
   :BaseView(rect,2, parent), timerId(0)
{
    nodeCount = 0;
    rectangleCount = 0;
    triangleCount = 0;
    //set seed
    QTime midnight(0, 0, 0);
    qsrand(midnight.secsTo(QTime::currentTime()));

    Control* node = addNewControl("AddNode", "Node");
    connect(node, SIGNAL(clicked()), this, SLOT(addNewNode()));
   
    Control* rec = addNewControl("AddRectangle", "Rectangle");
    connect(rec, SIGNAL(clicked()), this, SLOT(addNewRectangle()));

    Control* scramble = addNewControl("Scramble", "Scramble");
    connect(scramble, SIGNAL(clicked()), this, SLOT(scramble()));    

    Control* reset = addNewControl("Reset", "Reset");
    connect(reset, SIGNAL(clicked()), this, SLOT(resetView()));

    mCrash = new Control(this);
    mCrash->setObjectName("Crash");
    mCrash->setText("Crash");
    mCrash->setZValue(1);
    setCrashButton();
    mCrasher = new Crasher();
    connect(mCrash, SIGNAL(clicked()), mCrasher, SLOT(crash()));

}

NodeView::~NodeView()
{
    delete mCrasher;
}

void NodeView::scramble()
{
    if(scene()){
        QListIterator<QGraphicsItem*> i(scene()->items());
        while (i.hasNext()){
            QGraphicsItem* item = i.next();
            if(item->type() == NODE_TYPE || item->type() == RECTANGLE_TYPE ){
                item->setPos(randomPos(item->boundingRect()));
                item->update();
            }
        }
    }
}

void NodeView::resetView()
{
    if(scene()){
        QListIterator<QGraphicsItem*> i(scene()->items());
        while (i.hasNext()){
            QGraphicsItem* item = i.next();
            if(item->type() == NODE_TYPE || item->type() == RECTANGLE_TYPE || item->type() == TRIANGLE_TYPE ){
                scene()->removeItem(item);
                delete item;
            }
        }
    }
    nodeCount = 0;
    rectangleCount = 0;
    triangleCount = 0;
    addTriangle();
}

int NodeView::getNodeCount()
{
    return nodeCount;
}

int NodeView::getRectangleCount()
{
    return rectangleCount;
}

void NodeView::addNewNode()
{
    nodeCount++;
    Node *node = new Node(this);
    node->setObjectName("Node"+QString::number(nodeCount));
    node->setPos(randomPos(node->boundingRect()));
    connect(this, SIGNAL(sizeChange()), node, SLOT(checkPosition()));
}

void NodeView::addTriangle()
{
    triangleCount++;
    Triangle *node = new Triangle(this);
    node->setObjectName("Triangle"+QString::number(nodeCount));
    node->setPos(boundingRect().center());    
    connect(this, SIGNAL(sizeChange()), node, SLOT(checkPosition()));
}



void NodeView::addNewRectangle()
{
    rectangleCount++;
    Rectangle *rectangle = new Rectangle(this);
    rectangle->setObjectName("Rectangle"+QString::number(rectangleCount));
    rectangle->setPos(randomPos(rectangle->boundingRect()));
    connect(this, SIGNAL(sizeChange()), rectangle, SLOT(checkPosition()));
}


QPointF NodeView::randomPos(QRectF area)
{
    QRectF rect = boundingRect();
    qreal x = (rect.right()-area.width())*qrand()/(RAND_MAX+1.0); 
    qreal y = (rect.bottom()-area.height()-CONTROLTAB_HEIGHT)*qrand()/(RAND_MAX+1.0); 
    return QPointF(x,y);
}


void NodeView::keyPressEvent(QKeyEvent *event)
{
    switch (event->key()) {
    case Qt::Key_Enter:
        foreach (QGraphicsItem *item, scene()->items()) {
            if (qgraphicsitem_cast<Node *>(item))
                item->setPos(-150 + qrand() % 300, -150 + qrand() % 300);
        }
        break;
    default:
        QGraphicsWidget::keyPressEvent(event);
    }
}

