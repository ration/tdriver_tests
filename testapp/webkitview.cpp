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
*  Name        : webkitview.cpp
*  Part of     : Test application
*  Description : Test application web kit view
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

#include "webkitview.h"

#include <QDebug>
#include <QtGui>
#include <QGraphicsScene>
#include <QWheelEvent>
#include <QTime>
#include <QGraphicsProxyWidget>
#include <QUrl>
#include "control.h"
#include "testpage.h"

WebKitView::WebKitView(const QRectF& rect, QGraphicsItem* parent)
   :BaseView(rect,2, parent)
{
    QWebView* web = new QWebView();
    web->load(QUrl(TESTPAGE));
    proxy = new QGraphicsProxyWidget(this);
    proxy->setWidget(web);
    setWidgets();
    web->show();
}

WebKitView::~WebKitView()
{
    //delete webView;
}

void WebKitView::setWidgets()
{
    // Push a bit downwards
    QPointF corner = boundingRect().topLeft() + QPointF(CONTROL_SIZE+10,CONTROL_SIZE+10);

    proxy->setPos(corner);
    //limix maximun size

    QSizeF area;
    area.setWidth( boundingRect().bottomRight().x()-corner.x());
    area.setHeight(boundingRect().bottomRight().y()-corner.y());
    proxy->setMaximumSize(area);
}
