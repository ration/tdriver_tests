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
 
 
#include "mainwindow.h"

#include <QDebug>
#include <QtGui>
#include <QtPlugin> 
#include <QPluginLoader>
#include <QLibraryInfo>
#include <QGraphicsGridLayout>
#include <QTimer>
#include <QToolBar>
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

    determineSize();

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

    MultiGestureView* gestureView = new MultiGestureView(QRectF(0, 0, width, height));
    gestureView->setObjectName("gestureView");
    scene->addItem(gestureView);


    mViews.enqueue(zoomView);
    mViews.enqueue(rotateView);
    mViews.enqueue(tapView);
    mViews.enqueue(gestureView);
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
    if(mViews.head()->supportPinch()){
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
        mainView->centerOn(mViews.head());
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
        QTouchEvent *touchEvent = static_cast<QTouchEvent *>(event);        
        if(!primaryPoint(touchEvent)){
            mPressed = true;
            update();
            return true;
        }
        else{
            return QGraphicsWidget::sceneEvent(event);
        }
    }
    else if (event->type() == QEvent::TouchUpdate){
        QTouchEvent *touchEvent = static_cast<QTouchEvent *>(event);
        qDebug() << objectName() << "Square::sceneEvent touchUpdate";
        if(!primaryPoint(touchEvent)){
            if (touchEvent->touchPointStates() & Qt::TouchPointReleased) {
                mPressed = false;
                update();
                return true;
            }
        }
        else{
            return QGraphicsWidget::sceneEvent(event);
        }
    }
    else if ( event->type() == QEvent::TouchEnd){
        qDebug() << objectName() << "Square::sceneEvent touch end";
        QTouchEvent *touchEvent = static_cast<QTouchEvent *>(event);
        if(!primaryPoint(touchEvent)){
            mPressed = false;
            mCounter++;
            update();
            return true;
        }
        else{
            return QGraphicsWidget::sceneEvent(event);
        }
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
    return QGraphicsWidget::sceneEvent(event);
}

bool Square::primaryPoint(QTouchEvent* event)
{
    foreach(QTouchEvent::TouchPoint point, event->touchPoints()){
        if(point.isPrimary()){
            return true;
        }
    }
    return false;
}

void Square::mouseReleaseEvent( QGraphicsSceneMouseEvent * event )
{
    qDebug() << objectName() << "Square::mouseReleaseEvent";        
    mCounter++;
    mPressed = false;
    update();
}

void Square::mousePressEvent( QGraphicsSceneMouseEvent * event )
{
    qDebug() << objectName() << "Square::mousePressEvent";        
    mPressed = true;
    update();
}


MultiGestureView::MultiGestureView(const QRectF& rect, QGraphicsItem* parent)
    :MattiView(parent)
{
    setAcceptTouchEvents(true);
    myPenColors
            << QColor("green")
            << QColor("purple")
            << QColor("red")
            << QColor("blue")
            << QColor("yellow")
            << QColor("pink")
            << QColor("orange")
            << QColor("brown")
            << QColor("grey")
            << QColor("black");

    mSceneRect = rect;

    image = new QImage(mSceneRect.size().toSize(), QImage::Format_RGB32);
    image->fill(qRgb(255, 255, 255));

    mCounter = 0;
    hide();
}

MultiGestureView::~MultiGestureView()
{
   delete image;
}

QRectF MultiGestureView::boundingRect() const
{
    return mSceneRect;
}

QPainterPath MultiGestureView::shape() const
{
    QPainterPath path;
    path.addRect(mSceneRect);
    return path;
}

void MultiGestureView::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    const QRectF rect = boundingRect();
    painter->drawImage(rect.topLeft(), *image, rect);
}

bool MultiGestureView::sceneEvent(QEvent *event)
{
    switch (event->type()) {
    case QEvent::TouchBegin:        
    case QEvent::TouchUpdate:
    case QEvent::TouchEnd:
    {
        QList<QTouchEvent::TouchPoint> touchPoints = static_cast<QTouchEvent *>(event)->touchPoints();
        foreach (const QTouchEvent::TouchPoint &touchPoint, touchPoints) {
            QRectF rect = touchPoint.rect();
            if (rect.isEmpty()) {
                qreal diameter = qreal(20) * touchPoint.pressure();
                rect.setSize(QSizeF(diameter, diameter));
            }            

            switch (touchPoint.state()) {
            case Qt::TouchPointStationary:
                // don't do anything if this touch point hasn't moved
                continue;
            case Qt::TouchPointMoved:
                {
                    QPainter painter(image);
                    painter.setPen(Qt::NoPen);
                    painter.setBrush(myPenColors.at(touchPoint.id() % myPenColors.count()));
                    painter.drawEllipse(rect);
                    painter.end();
                    int rad = 2;
                    update(rect.toRect().adjusted(-rad,-rad, +rad, +rad));               
                    break;
                }
            default:
                {
                    if(!gestureIds.contains(touchPoint.id())){
                        mCounter++;
                        gestureIds.insert(touchPoint.id(), mCounter);
                    }
                    new Point(touchPoint.state(), myPenColors.at(touchPoint.id() % myPenColors.count()), rect, 
                              gestureIds.value(touchPoint.id()), this);
                    break;
                }
            }
        }
        break;
    }
    default:
        return QGraphicsWidget::sceneEvent(event);
    }
    return true;
}

Point::Point(Qt::TouchPointState type, QColor color, QRectF rect, int id, QGraphicsItem* parent)
    :QGraphicsObject(parent), mColor(color), mRect(rect)
{    
    QPointF center = rect.center();
    mRect.setWidth(50);
    mRect.setHeight(50);
    mRect.moveCenter(center);
    switch (type) {
    case Qt::TouchPointPressed:
        setObjectName("StartPoint"+QString::number(id));
        break;        
    case Qt::TouchPointReleased:
        setObjectName("EndPoint"+QString::number(id));
        break;
    default:
        break;
    }
}

QRectF Point::boundingRect() const
{
    return mRect;
}
QPainterPath Point::shape() const
{
    QPainterPath path;
    path.addRect(boundingRect());
    return path;
}

void Point::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *)
{
    painter->setBrush(mColor);
    painter->setPen(QPen(mColor, 0));
    painter->drawEllipse(boundingRect());
}

