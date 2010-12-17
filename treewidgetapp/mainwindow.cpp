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

#include <QtGui>

#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
   : QMainWindow(parent)
{
    setupUi(this);

    treeWidget->setColumnCount(1);

    treeWidget->setHeaderLabels(QStringList() << tr("Testing QTreeWidget"));

    QTreeWidgetItem *item1 = new QTreeWidgetItem(treeWidget);
    QTreeWidgetItem *item2 = new QTreeWidgetItem(treeWidget);
    QTreeWidgetItem *item3 = new QTreeWidgetItem(treeWidget);

    item1->setText(0, "Qt::Unchecked");
    item1->setCheckState(0, Qt::Unchecked);

    item2->setText(0, "Qt::PartiallyChecked");
    item2->setCheckState(0, Qt::PartiallyChecked);

    item3->setText(0, "Qt::Checked");
    item3->setCheckState(0, Qt::Checked);


}
