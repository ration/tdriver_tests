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
 
 
#ifndef POPUPMENU_H
#define POPUPMENU_H

#include <QtGui/QGraphicsView>
#include <QGraphicsWidget>
#include <QTimer>

class PopupMenu : public QGraphicsWidget
{
  Q_OBJECT

public:

  PopupMenu(const QRectF& vieportArea);
  ~PopupMenu(); 
 
  void exec();

signals:
  void nextView();

protected:
  void showEvent(QShowEvent *event);

private slots:
  void closeDialog();

private:
  QTimer mTimer;
  QRectF mRect;
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

class MenuButton : public QGraphicsWidget
{  
    Q_OBJECT
public:
    MenuButton(QRectF rect, Qt::GlobalColor colorOne, Qt::GlobalColor colorTwo, QGraphicsItem* parent=0);
    ~MenuButton(){};

    QRectF boundingRect() const;
    QPainterPath shape() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);

signals:
	void clicked();

protected:
    void mouseReleaseEvent(QGraphicsSceneMouseEvent *event);
	Qt::GlobalColor mColorOne;
	Qt::GlobalColor mColorTwo;
	QRectF mRect;
};


#endif
