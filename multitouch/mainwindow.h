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
 
 
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QtGui>
#include <QMainWindow>
#include <QQueue>
#include <QTouchEvent>

class MattiView;
class TextItem;
class CloseButton;
class Handle;

class MainWindow : public QMainWindow
{
    Q_OBJECT
	Q_PROPERTY(QString currentView READ currentViewName)

public:  
    MainWindow(QWidget* parent = 0);
    ~MainWindow();

	QString currentViewName();

protected:
	bool event(QEvent *event);

private slots:
	void changeView();
	void centerView(const MattiView&);

private:
	void determineSize();
    void pinchTriggered(QPinchGesture*);	

private:	
	QGraphicsScene* scene;
	QGraphicsView* mainView;
	bool mFullScreen;
	QQueue<MattiView*> mViews;
	qreal currentStepScaleFactor;
	qreal scaleFactor;
};

class MattiView : public QGraphicsWidget
{     
    Q_OBJECT
public:
  MattiView(QGraphicsItem* parent=0);
  virtual void showView(){show();}
  virtual void hideView(){hide();}
  virtual bool gestureOccured(QGestureEvent* event);
  virtual bool supportPinch() = 0;
};

class ZoomView : public MattiView
{
    Q_OBJECT
public:
    ZoomView(const QRectF& rect, QGraphicsItem* parent=0);
    ~ZoomView(){};

    QRectF boundingRect() const;
    QPainterPath shape() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);
	virtual bool supportPinch(){return true;}

 private:
	QRectF mSceneRect;
};

class RotateView : public MattiView
{
    Q_OBJECT
 public:
    RotateView(const QRectF& rect, QGraphicsItem* parent=0);
    ~RotateView();

    QRectF boundingRect() const;
    QPainterPath shape() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);
	virtual bool supportPinch(){return true;}

protected:
	bool gestureOccured(QGestureEvent* event);
    void rotateTriggered(QPinchGesture*);	

 private:
	QRectF mSceneRect;
	Handle* mHandle;
};

class MultiTapView : public MattiView
{
  Q_OBJECT
 public:
    MultiTapView(const QRectF& rect, QGraphicsItem* parent=0);
    ~MultiTapView();

    QRectF boundingRect() const;
    QPainterPath shape() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);
	bool gestureOccured(QGestureEvent* event);
	virtual bool supportPinch(){return false;}

 private:
	QRectF mSceneRect;
	Handle* mHandle;
};

class Handle : public QGraphicsWidget
{
    Q_OBJECT
public:
    Handle(QGraphicsItem* parent=0);
    ~Handle(){};

    QRectF boundingRect() const;
    QPainterPath shape() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);

};

class Square : public QGraphicsWidget
{
    Q_OBJECT
    Q_PROPERTY(int tapCount READ getCounter)
    Q_PROPERTY(bool pressed READ isPressed)
			

public:
    Square(const QSizeF& size, Qt::GlobalColor color, QGraphicsItem* parent=0);
    ~Square(){};

    QRectF boundingRect() const;
    QPainterPath shape() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);

	int getCounter(){return mCounter;}
	bool isPressed(){return mPressed;}

protected:
    bool sceneEvent(QEvent *event);
	void mouseReleaseEvent( QGraphicsSceneMouseEvent * event );
	void mousePressEvent( QGraphicsSceneMouseEvent * event );
	bool primaryPoint(QTouchEvent* event);

private:
	QRectF mRect;
	Qt::GlobalColor mColor;
	bool mPressed;
	int mCounter;
};


class MultiGestureView : public MattiView
{
    Q_OBJECT
 public:
    MultiGestureView(const QRectF& rect, QGraphicsItem* parent=0);
    ~MultiGestureView();

    QRectF boundingRect() const;
    QPainterPath shape() const;
	void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);
	virtual bool supportPinch(){return false;}

protected:
    bool sceneEvent(QEvent *event);

private:
	QRectF mSceneRect;
    QList<QColor> myPenColors;
    QImage *image;
	QHash<int, int> gestureIds;
	int mCounter;
};

class Point : public QGraphicsObject
{
    Q_OBJECT
	Q_PROPERTY(QString color READ color)

public:
    Point(Qt::TouchPointState type, QColor color, QRectF rect, int id, QGraphicsItem* parent=0);
    ~Point(){};

    QRectF boundingRect() const;
    QPainterPath shape() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *);	
	QString color(){return mColor.name();}
private:
	QColor mColor;
	QRectF mRect;
};


#endif
