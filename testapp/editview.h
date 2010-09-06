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
*  Name        : editview.h
*  Part of     : Test application
*  Description : Test application edit window
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

#ifndef EDITVIEW_H
#define EDITVIEW_H

#include <QtGui/QGraphicsView>
#include <QGraphicsWidget>
#include <QDateTimeEdit>
//#include <QtWebKit/QWebView>
#include "baseview.h"



class EditView : public BaseView
{
    Q_OBJECT


public:
    EditView(const QRectF& rect, QGraphicsItem* parent=0);
    ~EditView();
 

    void setWidgets();

signals:
	void sizeChange();

private slots:
  void launchModal();
  void launchNonModal();


private:
};

class MovableMenu : public QGraphicsWidget
{
    Q_OBJECT


public:
    MovableMenu(QGraphicsWidget* parent=0);
    ~MovableMenu();

protected:
    QVariant itemChange(GraphicsItemChange change, const QVariant &value);

};

class PopupItem : public QGraphicsWidget
{
  Q_OBJECT
  Q_PROPERTY(QString text READ getText)

public:

  PopupItem(const QString& message, QGraphicsWidget* parent=0);
  ~PopupItem(); 

  QRectF boundingRect() const;
  QPainterPath shape() const;
  void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);
  
  void exec();
  QString getText();

protected:
  void showEvent(QShowEvent *event);

private slots:
  void closeDialog();

private:
  QString mMessage;
  QTimer mTimer;
};

class Background : public QGraphicsWidget
{
  Q_OBJECT

public:
  Background(QGraphicsWidget* parent=0);
  ~Background();
  
  QRectF boundingRect() const;
  void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);
  QPainterPath shape() const;

protected:
  bool sceneEvent(QEvent *event);

};

#endif
