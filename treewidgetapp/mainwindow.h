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

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QtGui/QApplication>
#include <QtGui/QHeaderView>
#include <QtGui/QMainWindow>
#include <QtGui/QTreeWidget>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class QTreeWidget;
class QTreeWidgetItem;

QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);

    QWidget *centralwidget;
    QVBoxLayout *vboxLayout;
    QTreeWidget *treeWidget;

    void setupUi(QMainWindow *MainWindowBase)
    {
        if (MainWindowBase->objectName().isEmpty()){

          MainWindowBase->setObjectName(QString::fromUtf8("MainWindowBase"));

        }

        MainWindowBase->resize(360, 480);

        centralwidget = new QWidget(MainWindowBase);
        centralwidget->setObjectName(QString::fromUtf8("centralwidget"));

        vboxLayout = new QVBoxLayout(centralwidget);

        vboxLayout->setObjectName(QString::fromUtf8("vboxLayout"));

        MainWindowBase->setCentralWidget( centralwidget );

        treeWidget = new QTreeWidget();
        treeWidget->setObjectName(QString::fromUtf8("exampleWidget"));
        treeWidget->setSelectionMode(QAbstractItemView::ExtendedSelection);
        vboxLayout->addWidget(treeWidget);

        QMetaObject::connectSlotsByName(MainWindowBase);

    } // setupUi


private:

};

#endif
