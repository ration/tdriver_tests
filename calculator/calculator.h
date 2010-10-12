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




#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QDialog>
#include <QStringList>


QT_BEGIN_NAMESPACE
/* Insert Testabilityinterface into namespace */
class TestabilityInterface;
/* End-of Testabilityinterface into namespace */
class QLineEdit;
class QMenuBar;
class QToolBar;
class QToolButton;
class QGridLayout;
QT_END_NAMESPACE
class Button;


class Calculator : public QDialog
{
    Q_OBJECT

public:
    Calculator(QWidget *parent = 0);

protected:
    void resizeEvent(QResizeEvent * event);

private slots:
    void digitClicked();
    void unaryOperatorClicked();
    void additiveOperatorClicked();
    void multiplicativeOperatorClicked();
    void equalClicked();
    void pointClicked();
    void changeSignClicked();
    void backspaceClicked();
    void clear();
    void clearAll();
    void clearMemory();
    void readMemory();
    void setMemory();
    void addToMemory();

    void evade();

private:
    Button *createButton(const QString &text, const char *member, const QString &name = "");
    void abortOperation();
    bool calculate(double rightOperand, const QString &pendingOperator);
        bool eventFilter(QObject * object, QEvent *event);
    /* Add Testabilityinterface to private objects */
    TestabilityInterface* testabilityInterface;
    /* Endof add Testabilityinterface to private objects */
    double sumInMemory;
    double sumSoFar;
    double factorSoFar;
    QString pendingAdditiveOperator;
    QString pendingMultiplicativeOperator;
    bool waitingForOperand;
    QGridLayout *mainLayout;
    QMenuBar *menuBar;
    QLineEdit *display;
    QToolBar *toolBar;
    QToolButton *evadingButton;
    QAction *evadeAction;

    enum { NumDigitButtons = 10 };
    QStringList buttonNames;
    Button *digitButtons[NumDigitButtons];
};

#endif
