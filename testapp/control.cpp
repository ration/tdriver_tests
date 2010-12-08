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

#include "control.h"
#include "controlview.h"

Control::Control(QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{
    setFlag(ItemIsSelectable);
    setCacheMode(DeviceCoordinateCache);
    setZValue(4);
}


QRectF Control::boundingRect() const
{
    return QRectF(0, 0, CONTROL_SIZE, CONTROL_SIZE);
}

QPainterPath Control::shape() const
{
    QPainterPath path;
    path.addRect(0, 0, CONTROL_SIZE, CONTROL_SIZE);
    return path;
}

void Control::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    if (option->state & QStyle::State_Sunken) {
        painter->setBrush(QBrush(Qt::cyan));
    }
    else{
        painter->setBrush(QBrush(Qt::darkCyan));
    }
    painter->drawRoundedRect(0, 0, CONTROL_SIZE, CONTROL_SIZE, 3, 3);
    painter->setPen(QPen(Qt::black, 2));

    //QFont font;
    ///font.setBold(true);
    //font.setPointSize(qRound(CONTROL_SIZE*0.1));
    painter->setFont(font());
    painter->drawText(QRectF(0, 0, CONTROL_SIZE, CONTROL_SIZE), Qt::AlignBottom | Qt::AlignHCenter, mText);
}


void Control::click(void)
{
    emit clicked();
}


void Control::mousePressEvent(QGraphicsSceneMouseEvent *event)
{
    update();
    QGraphicsItem::mousePressEvent(event);
}

void Control::mouseReleaseEvent(QGraphicsSceneMouseEvent *event)
{
    update();
    QGraphicsItem::mouseReleaseEvent(event);
    emit clicked();
}

void Control::setText(const QString& text)
{
    mText = text;
}

QString Control::getText()
{
    return mText;
}

