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
*  Name        : node.h
*  Part of     : Test application
*  Description : Test application node
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


#ifndef SHAPE_H
#define SHAPE_H

#include <QGraphicsWidget>
#include <QList>

class NodeView;
QT_BEGIN_NAMESPACE
class QGraphicsSceneMouseEvent;
QT_END_NAMESPACE



enum GraphicsItemType
{
    NODE_TYPE = QGraphicsItem::UserType + 1000,
	RECTANGLE_TYPE,
	TRIANGLE_TYPE
};

class Shape : public QGraphicsWidget 
{
    Q_OBJECT
	Q_PROPERTY(QString color READ shapeColor)

public:
    Shape(QGraphicsItem* parent=0);

    virtual QRectF boundingRect() const =0;

public slots:
	void checkPosition();

protected:
    QVariant itemChange(GraphicsItemChange change, const QVariant &value);

    void mousePressEvent(QGraphicsSceneMouseEvent *event);
    void mouseReleaseEvent(QGraphicsSceneMouseEvent *event);
	QString shapeColor();
	void paintItems();
protected:
    QPointF newPos;
	QString colorName;
};



#endif
