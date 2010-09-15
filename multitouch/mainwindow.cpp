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
 
 
#include "mainwindow.h"

#include <QDebug>
#include <QtGui>
#include <QtPlugin> 
#include <QPluginLoader>
#include <QLibraryInfo>
#include <QGraphicsGridLayout>
#include <QTimer>
#include <QToolBar>
#include "popupmenu.h"
#include <QGesture>
#include <QTapAndHoldGesture>

MainWindow::MainWindow(QWidget* parent)
    :QMainWindow(parent) 
{

    setAttribute(Qt::WA_AcceptTouchEvents);    
    grabGesture(Qt::PinchGesture);
    //grabGesture(Qt::TapAndHoldGesture);
    //    grabGesture(Qt::SwipeGesture);

    currentStepScaleFactor = 1;
    scaleFactor = 1;

    scene = new QGraphicsScene(this);
    scene->setItemIndexMethod(QGraphicsScene::NoIndex);
    mFullScreen = false;
    determineSize();

    mainView = new QGraphicsView(scene);
    mainView->setObjectName("GraphicsView");
    mainView->viewport()->setAttribute(Qt::WA_AcceptTouchEvents);
    mainView->setDragMode(QGraphicsView::NoDrag);
    mainView->setAttribute(Qt::WA_AcceptTouchEvents);    
    mainView->setCacheMode(QGraphicsView::CacheBackground);
    mainView->setViewportUpdateMode(QGraphicsView::BoundingRectViewportUpdate);
    mainView->setRenderHint(QPainter::Antialiasing);
    mainView->setTransformationAnchor(QGraphicsView::AnchorUnderMouse);
    mainView->setResizeAnchor(QGraphicsView::AnchorViewCenter);
    mainView->setVerticalScrollBarPolicy (Qt::ScrollBarAlwaysOff);
    mainView->setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
    QToolBar* toolBar = new QToolBar(this);
    toolBar->setMovable(false);
    QAction* nextView = toolBar->addAction("NEXT");    
    QAction* quit = toolBar->addAction("QUIT");    
    toolBar->insertSeparator(quit);
    addToolBar(Qt::BottomToolBarArea, toolBar);
    connect(nextView, SIGNAL(triggered()), this, SLOT(changeView()));
    connect(quit, SIGNAL(triggered()), qApp, SLOT(quit()));


    setCentralWidget(mainView);    
    setObjectName("MainWindow");

    int width = minimumSize().width();
    int height = minimumSize().height()-toolBar->height();
    ZoomView* zoomView = new ZoomView(QRectF(0, 0, width, height));
    zoomView->setObjectName("zoomView");
    scene->addItem(zoomView);
    
    RotateView* rotateView = new RotateView(QRectF(0, 0, width, height));
    rotateView->setObjectName("rotateView");
    scene->addItem(rotateView);

    MultiTapView* tapView = new MultiTapView(QRectF(0, 0, width, height));
    tapView->setObjectName("tapView");
    scene->addItem(tapView);


    mViews.enqueue(zoomView);
    mViews.enqueue(rotateView);
    mViews.enqueue(tapView);
    /*
    foreach(MattiView* view, mViews){
        connect(view, SIGNAL(centerMe(const MattiView&)), this, SLOT(centerView(const MattiView&)));
    }
    */

    mViews.head()->showView();
}

MainWindow::~MainWindow()
{
}

bool MainWindow::event(QEvent *event)
{
    if (event->type() == QEvent::Gesture)
        if(!mViews.head()->gestureOccured(static_cast<QGestureEvent*>(event))){
            QGestureEvent* gesture = static_cast<QGestureEvent*>(event);
            if (QGesture *pinch = gesture->gesture(Qt::PinchGesture)){
                pinchTriggered(static_cast<QPinchGesture *>(pinch));
            }
            return true;
        }
     return QWidget::event(event);
}

void MainWindow::pinchTriggered(QPinchGesture *gesture)
{
    QPinchGesture::ChangeFlags changeFlags = gesture->changeFlags();
    if (changeFlags & QPinchGesture::ScaleFactorChanged) {
        qreal value = gesture->property("scaleFactor").toReal();
        currentStepScaleFactor = value;
    }
    if (gesture->state() == Qt::GestureFinished) {
        scaleFactor *= currentStepScaleFactor;
        currentStepScaleFactor = 1;
    }
    if((currentStepScaleFactor * scaleFactor) < 1){
        currentStepScaleFactor = 1;
        scaleFactor = 1;
        mainView->setTransform(QTransform().scale(currentStepScaleFactor * scaleFactor,currentStepScaleFactor * scaleFactor));
    }
    else{
        mainView->setTransform(QTransform().scale(currentStepScaleFactor * scaleFactor,currentStepScaleFactor * scaleFactor));
    }
}



void MainWindow::centerView(const MattiView& view)
{
    mainView->centerOn(&view);
}

void MainWindow::changeView()
{
    MattiView* current = mViews.dequeue();
    current->hideView();
    mViews.head()->showView();
    mViews.enqueue(current);
}

void MainWindow::determineSize()
{
    QRect rect = qApp->desktop()->screenGeometry();    
    if(rect.width() > 864 && !mFullScreen ){
        setMinimumSize(864, 480);
        setMaximumSize(864, 480);
    }
    else{
        setMinimumSize(rect.size());
        setMaximumSize(rect.size());
        showFullScreen();
    }
    //scene->setSceneRect(0, 0, minimumSize().width(), minimumSize().height());
}

MattiView::MattiView(QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{
    setFlag(ItemIsMovable, false);
}

bool MattiView::gestureOccured(QGestureEvent* event)
{
    return false;
}

ZoomView::ZoomView(const QRectF& rect, QGraphicsItem* parent)
    :MattiView(parent)
{
    mSceneRect = rect;
    hide();
}
QRectF ZoomView::boundingRect() const
{
    return mSceneRect;
}

QPainterPath ZoomView::shape() const
{
    QPainterPath path;
    path.addRect(mSceneRect);
    return path;
}


void ZoomView::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    painter->setBrush(Qt::white);
    painter->drawRect(boundingRect());
    painter->setPen(QPen(Qt::black, 0));
    painter->setFont(font());
    painter->drawText(boundingRect(), Qt::AlignCenter | Qt::AlignHCenter, "Zoom in"); 
}


RotateView::RotateView(const QRectF& rect, QGraphicsItem* parent)
    :MattiView(parent)
{
    //    setAcceptTouchEvents(true);
    //    grabGesture(Qt::PinchGesture);
    mSceneRect = rect;
    mHandle = new Handle(this);
    mHandle->setObjectName("rotateBox");
    mHandle->setPos(boundingRect().center() - mHandle->boundingRect().center());
    hide();
}


bool RotateView::gestureOccured(QGestureEvent* event)
{
    if (event->type() == QEvent::Gesture){
        QGestureEvent* gesture = static_cast<QGestureEvent*>(event);
        if (QGesture *pinch = gesture->gesture(Qt::PinchGesture)){
            rotateTriggered(static_cast<QPinchGesture *>(pinch));
            return true;
        }
    }
    return false;
}


void RotateView::rotateTriggered(QPinchGesture *gesture)
{
    QPinchGesture::ChangeFlags changeFlags = gesture->changeFlags();
    if (changeFlags & QPinchGesture::RotationAngleChanged) {
        qreal angle = gesture->property("rotationAngle").toReal();        
        mHandle->setTransformOriginPoint(mHandle->boundingRect().center());
        mHandle->setRotation(angle);
    }
}

RotateView::~RotateView()
{
    delete mHandle;
}

QRectF RotateView::boundingRect() const
{
    return mSceneRect;
}

QPainterPath RotateView::shape() const
{
    QPainterPath path;
    path.addRect(mSceneRect);
    return path;
}

void RotateView::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    painter->setBrush(Qt::white);
    painter->drawRect(boundingRect());
}

Handle::Handle(QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{
    setFlag(ItemIsMovable, false); 
}

QRectF Handle::boundingRect() const
{
    return QRectF(0, 0, 200, 200);
}

QPainterPath Handle::shape() const
{
    QPainterPath path;
    path.addRect(boundingRect());
    return path;
}

void Handle::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    painter->setBrush(Qt::red);
    painter->drawRect(boundingRect());
    painter->setPen(QPen(Qt::black, 0));
    painter->setFont(font());
    painter->drawText(boundingRect(), Qt::AlignCenter | Qt::AlignHCenter, "Rotate me"); 

}



MultiTapView::MultiTapView(const QRectF& rect, QGraphicsItem* parent)
    :MattiView(parent)
{
    setAcceptTouchEvents(true);
    mSceneRect = rect;
    QSizeF size = rect.size()/2;
    size.setWidth(size.width()-15);
    size.setHeight(size.height()-15);
    QGraphicsGridLayout* layout = new QGraphicsGridLayout();
    layout->setGeometry(rect);

    Square* topLeft = new Square(size, Qt::red);
    topLeft->setObjectName("topLeft");
    Square* topRight = new Square(size, Qt::blue);
    topRight->setObjectName("topRight");
    Square* lowLeft = new Square(size, Qt::green);
    lowLeft->setObjectName("lowLeft");
    Square* lowRight = new Square(size, Qt::yellow);
    lowRight->setObjectName("lowRight");

    layout->addItem(topLeft, 0, 0);
    layout->addItem(topRight, 0, 1);
    layout->addItem(lowLeft, 1, 0);
    layout->addItem(lowRight, 1, 1);
    layout->setColumnMinimumWidth(0, size.width()); 
    layout->setColumnMinimumWidth(1, size.width()); 
    layout->setRowMinimumHeight(0, size.height()); 
    layout->setRowMinimumHeight(1, size.height()); 
    setLayout(layout);
    hide();
}

MultiTapView::~MultiTapView()
{
}

QRectF MultiTapView::boundingRect() const
{
    return mSceneRect;
}

QPainterPath MultiTapView::shape() const
{
    QPainterPath path;
    path.addRect(mSceneRect);
    return path;
}

void MultiTapView::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    painter->setBrush(Qt::white);
    painter->drawRect(boundingRect());
}

bool MultiTapView::gestureOccured(QGestureEvent* event)
{
    return true;
}


Square::Square(const QSizeF& size, Qt::GlobalColor color, QGraphicsItem* parent)
    :QGraphicsWidget(parent)
{
    setAcceptTouchEvents(true);
    mColor = color;
    setFlag(ItemIsMovable, false);     
    mRect.setSize(size);
    mPressed = false;
    mCounter = 0;
    //  grabGesture(Qt::TapAndHoldGesture);
}

QRectF Square::boundingRect() const
{
    return mRect;
}

QPainterPath Square::shape() const
{
    QPainterPath path;
    path.addRect(boundingRect());
    return path;
}

void Square::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    if (mPressed) {      
        painter->setBrush(QColor(mColor).darker());
    }
    else{
        painter->setBrush(mColor);
    }    
    painter->drawRect(boundingRect());
    painter->setPen(QPen(Qt::black, 0));
    painter->setFont(font());
    painter->drawText(boundingRect(), Qt::AlignCenter | Qt::AlignHCenter, QString::number(mCounter)); 
}


bool Square::sceneEvent(QEvent *event)
{
    qDebug() << objectName() << "Square::sceneEvent: " << QString::number(event->type());
    if ( event->type() == QEvent::TouchBegin ){
        qDebug() << objectName() << "Square::sceneEvent touchBegin";
        mPressed = true;
        update();
        return true;
    }
    else if (event->type() == QEvent::TouchUpdate){
        QTouchEvent *touchEvent = static_cast<QTouchEvent *>(event);
        qDebug() << objectName() << "Square::sceneEvent touchUpdate";
        if (touchEvent->touchPointStates() & Qt::TouchPointReleased) {
            mPressed = false;
            update();
        }
        return true;
    }
    else if ( event->type() == QEvent::TouchEnd){
        qDebug() << objectName() << "Square::sceneEvent touch end";
        mPressed = false;
        mCounter++;
        update();
        return true;
    }
    else if( event->type() == QEvent::Gesture){
        qDebug() << objectName() << "Square::sceneEvent gesture";
        QGestureEvent* gesture = static_cast<QGestureEvent*>(event);
        if(gesture->gesture(Qt::TapAndHoldGesture)){
            QTapAndHoldGesture* tap = static_cast<QTapAndHoldGesture*>(gesture->gesture(Qt::TapAndHoldGesture));
            if(tap->state() == Qt::GestureStarted || tap->state() == Qt::GestureUpdated ){
                qDebug() << objectName() << "Square::sceneEvent gesture tap start";
                mPressed = true;
                update();
            }
            else{
                qDebug() << objectName() << "Square::sceneEvent gesture tap end or cancel";
                mPressed = false;
                update();
            }
        }
        return QGraphicsWidget::sceneEvent(event);
    }
    else{
        return QGraphicsWidget::sceneEvent(event);
    }
}

void Square::mouseReleaseEvent( QGraphicsSceneMouseEvent * event )
{
    mCounter++;
    mPressed = false;
    update();
}
void Square::mousePressEvent( QGraphicsSceneMouseEvent * event )
{
    mPressed = true;
    update();
}
