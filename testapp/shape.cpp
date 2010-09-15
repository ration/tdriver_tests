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
*  Name        : shape.cpp
*  Part of     : Test application
*  Description : Test application shape
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

#include "shape.h"
#include "controlview.h"
#include "controltab.h"

Shape::Shape(QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{}

QString Shape::shapeColor()
{
    return colorName;
}

QVariant Shape::itemChange(GraphicsItemChange change, const QVariant &value)
{
    if (change == ItemPositionChange && scene()) {
         paintItems();
         // value is the new position.
         QPointF newPos = value.toPointF();         
         QRectF rect = scene()->sceneRect();
         if(parentItem()){
             rect = parentItem()->boundingRect();
         }

         if (!rect.contains(newPos)) {
             // Keep the item inside the scene rect.
             newPos.setX(qMin((rect.right() - boundingRect().width()), qMax(newPos.x(), rect.left())));
             newPos.setY(qMin((rect.bottom() - boundingRect().height() - CONTROLTAB_HEIGHT), qMax(newPos.y(), rect.top())));             
             return newPos;
         }
    }
    return QGraphicsItem::itemChange(change, value);
}

void Shape::paintItems()
{
    if(scene()){
        QListIterator<QGraphicsItem*> i(scene()->items());
        while (i.hasNext()){
            i.next()->update();
        }
    }
}

void Shape::checkPosition()
{
    setPos(itemChange(ItemPositionChange, scenePos()).toPointF());    
}

void Shape::mousePressEvent(QGraphicsSceneMouseEvent *event)
{    
    update();
    QGraphicsItem::mousePressEvent(event);
}

void Shape::mouseReleaseEvent(QGraphicsSceneMouseEvent *event)
{
    update();
    QGraphicsItem::mouseReleaseEvent(event);
}
