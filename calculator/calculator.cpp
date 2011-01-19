/*************************************************************************
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

#include <math.h>

#include "button.h"
#include "calculator.h"
/*Add following libraries to enable testabilityloading and testailiby if not already included */
#include <QtPlugin>
#include <QPluginLoader>
#include <QLibraryInfo>
#include "testabilityinterface.h" //this file needs to be copied to inc folder from qttas package
/*Endof adding files */



Calculator::Calculator(QWidget *parent)
    : QDialog(parent)
{

    /* In beginning of main file: activate testailiby plugin if available */
    QString testabilityPlugin = "testability/testability";
    QString testabilityPluginPostfix = ".dll";

#ifdef Q_OS_LINUX
    testabilityPluginPostfix = ".so";
    testabilityPlugin = "testability/libtestability";
#endif

#ifdef Q_WS_MAC
    testabilityPluginPostfix = ".dylib";
    testabilityPlugin = "testability/libtestability";
#endif

    testabilityPlugin = QLibraryInfo::location(QLibraryInfo::PluginsPath)
                        + QObject::tr("/") + testabilityPlugin + testabilityPluginPostfix;
    QPluginLoader loader(testabilityPlugin.toLatin1().data());

    QObject *plugin = loader.instance();
    if (plugin) {
        qDebug("Testability plugin loaded successfully!");
        testabilityInterface = qobject_cast<TestabilityInterface *>(plugin);

        if (testabilityInterface) {
            qDebug("Testability interface obtained!");
            testabilityInterface->Initialize();
        } else {
            qDebug("Failed to get testability interface!");
        }
    } else {
        qDebug("Testability plugin %s load failed with error:%s",
               testabilityPlugin.toLatin1().data(), loader.errorString().toLatin1().data());
    }

    /* Endof activate testailiby plugin if available */

#ifdef Q_OS_SYMBIAN
    QRect rect = qApp->desktop()->screenGeometry();
    setMinimumSize(rect.size());
    setMaximumSize(rect.size());
    showFullScreen();
#endif

    sumInMemory = 0.0;
    sumSoFar = 0.0;
    factorSoFar = 0.0;
    waitingForOperand = true;
    display = new QLineEdit("0");
    display->setReadOnly(true);
    display->setAlignment(Qt::AlignRight);
    display->setMaxLength(15);

    // TDriver test scripts can be made simpler and easier to understand by setting object names like this.
    display->setObjectName("display");

    QFont font = display->font();
    font.setPointSize(font.pointSize() + 8);
    display->setFont(font);

    buttonNames << "zeroButton" << "oneButton" << "twoButton" << "threeButton" << "fourButton"
            << "fiveButton" << "sixButton" << "sevenButton" << "eightButton" << "nineButton";
    for (int i = 0; i < NumDigitButtons; ++i) {
        digitButtons[i] = createButton(QString::number(i), SLOT(digitClicked()), buttonNames[i]);
    }

    Button *pointButton = createButton(tr("."), SLOT(pointClicked()), "pointButton");
    Button *changeSignButton = createButton(tr("\261"), SLOT(changeSignClicked()), "changeSignButton");

    // Some objects may not have a defined object name.
    // TDriver scripts must refer to such objects using other attributes, such as the displayed text.
    Button *backspaceButton = createButton(tr("Backspace"), SLOT(backspaceClicked()));
    Button *clearButton = createButton(tr("Clear"), SLOT(clear()));
    Button *clearAllButton = createButton(tr("Clear All"), SLOT(clearAll()), "clearAllButton");

    Button *clearMemoryButton = createButton(tr("MC"), SLOT(clearMemory()), "clearMemoryButton");
    Button *readMemoryButton = createButton(tr("MR"), SLOT(readMemory()), "readMemoryButton");
    Button *setMemoryButton = createButton(tr("MS"), SLOT(setMemory()), "setMemoryButton");
    Button *addToMemoryButton = createButton(tr("M+"), SLOT(addToMemory()), "addToMemoryButton");

    Button *divisionButton = createButton(tr("\367"), SLOT(multiplicativeOperatorClicked()), "divisionButton");
    Button *timesButton = createButton(tr("\327"), SLOT(multiplicativeOperatorClicked()), "timesButton");
    Button *minusButton = createButton(tr("-"), SLOT(additiveOperatorClicked()), "minusButton");
    Button *plusButton = createButton(tr("+"), SLOT(additiveOperatorClicked()), "plusButton");

    Button *squareRootButton = createButton(tr("Sqrt"), SLOT(unaryOperatorClicked()), "squareRootButton");
    Button *powerButton = createButton(tr("x\262"), SLOT(unaryOperatorClicked()), "powerButton");
    Button *reciprocalButton = createButton(tr("1/x"), SLOT(unaryOperatorClicked()), "reciprocalButton");
    Button *equalButton = createButton(tr("="), SLOT(equalClicked()), "equalButton");

    mainLayout = new QGridLayout;
    mainLayout->setSizeConstraint(QLayout::SetFixedSize);

    menuBar = new QMenuBar;
    menuBar->setObjectName("menuBar");
    QMenu *mainMenu = menuBar->addMenu(tr("&Menu"));
    mainMenu->menuAction()->setObjectName("mainMenuAction");
    mainMenu->setObjectName("mainMenu");
    menuBar->addMenu(tr("Empty"))->menuAction()->setObjectName("mainEmptyAction");

    toolBar = new QToolBar;
    toolBar->setObjectName("toolBar");

    QAction *clearAction = toolBar->addAction(tr("&Clear"));
    clearAction->setObjectName("clearAction");
    mainMenu->addAction(clearAction);
    connect(clearAction, SIGNAL(triggered()), this, SLOT(clear()));

    mainMenu->addSeparator();

    QAction *exitAction = mainMenu->addAction(tr("&Exit"));
    exitAction->setObjectName("exitAction");
    toolBar->addAction(exitAction);
    connect(exitAction, SIGNAL(triggered()), qApp, SLOT(quit()));

    evadeAction = new QAction(tr("*"), this);
    evadeAction->setObjectName("evadeAction");
    connect(evadeAction, SIGNAL(hovered()), this, SLOT(evade()));
    connect(evadeAction, SIGNAL(triggered()), this, SLOT(evade()));

    evadingButton = new QToolButton();
    evadingButton->setObjectName("evadingButton");
    evadingButton->setDefaultAction(evadeAction);

    int button1stRow = 3;
    mainLayout->addWidget(menuBar, 0, 0, 1, -1);
    mainLayout->addWidget(display, 1, 0, 1, -1);
    mainLayout->addWidget(toolBar, 2, 0, 1, -1);

    mainLayout->addWidget(backspaceButton, 0+button1stRow, 0, 1, 2);
    mainLayout->addWidget(clearButton, 0+button1stRow, 2, 1, 2);
    mainLayout->addWidget(clearAllButton, 0+button1stRow, 4, 1, 2);

    mainLayout->addWidget(clearMemoryButton, 1+button1stRow, 0);
    mainLayout->addWidget(readMemoryButton, 2+button1stRow, 0);
    mainLayout->addWidget(setMemoryButton, 3+button1stRow, 0);
    mainLayout->addWidget(addToMemoryButton, 4+button1stRow, 0);

    for (int i = 1; i < NumDigitButtons; ++i) {
        int row = ((9 - i) / 3) + 1;
        int column = ((i - 1) % 3) + 1;
        mainLayout->addWidget(digitButtons[i], row+button1stRow, column);
    }

    mainLayout->addWidget(digitButtons[0], 4+button1stRow, 1);
    mainLayout->addWidget(pointButton, 4+button1stRow, 2);
    mainLayout->addWidget(changeSignButton, 4+button1stRow, 3);

    mainLayout->addWidget(divisionButton, 1+button1stRow, 4);
    mainLayout->addWidget(timesButton, 2+button1stRow, 4);
    mainLayout->addWidget(minusButton, 3+button1stRow, 4);
    mainLayout->addWidget(plusButton, 4+button1stRow, 4);

    mainLayout->addWidget(squareRootButton, 1+button1stRow, 5);
    mainLayout->addWidget(powerButton, 2+button1stRow, 5);
    mainLayout->addWidget(reciprocalButton, 3+button1stRow, 5);
    mainLayout->addWidget(equalButton, 4+button1stRow, 5);

    mainLayout->addWidget(evadingButton, 0, 5, 1, 1, Qt::AlignCenter);

    setLayout(mainLayout);
    setWindowTitle(tr("Calculator"));
    installEventFilter( this );
}

void Calculator::resizeEvent(QResizeEvent * event)
{
    Q_UNUSED(event);
#ifdef Q_OS_SYMBIAN
//     QRect rect = qApp->desktop()->screenGeometry();
//     setMinimumSize(rect.size());
//     setMaximumSize(rect.size());
//     showFullScreen();
#endif
}

void Calculator::digitClicked()
{
    Button *clickedButton = qobject_cast<Button *>(sender());
    int digitValue = clickedButton->text().toInt();
    if (display->text() == "0" && digitValue == 0.0)
        return;

    if (waitingForOperand) {
        display->clear();
        waitingForOperand = false;
    }
    display->setText(display->text() + QString::number(digitValue));
}

void Calculator::unaryOperatorClicked()
{
    Button *clickedButton = qobject_cast<Button *>(sender());
    QString clickedOperator = clickedButton->text();
    double operand = display->text().toDouble();
    double result = 0.0;

    if (clickedOperator == tr("Sqrt")) {
        if (operand < 0.0) {
            abortOperation();
            return;
        }
        result = sqrt(operand);
    } else if (clickedOperator == tr("x\262")) {
        result = pow(operand, 2.0);
    } else if (clickedOperator == tr("1/x")) {
        if (operand == 0.0) {
            abortOperation();
            return;
        }
        result = 1.0 / operand;
    }
    display->setText(QString::number(result));
    waitingForOperand = true;
}

void Calculator::additiveOperatorClicked()
{
    Button *clickedButton = qobject_cast<Button *>(sender());
    QString clickedOperator = clickedButton->text();
    double operand = display->text().toDouble();

    if (!pendingMultiplicativeOperator.isEmpty()) {
        if (!calculate(operand, pendingMultiplicativeOperator)) {
            abortOperation();
            return;
        }
        display->setText(QString::number(factorSoFar));
        operand = factorSoFar;
        factorSoFar = 0.0;
        pendingMultiplicativeOperator.clear();
    }

    if (!pendingAdditiveOperator.isEmpty()) {
        if (!calculate(operand, pendingAdditiveOperator)) {
            abortOperation();
            return;
        }
        display->setText(QString::number(sumSoFar));
    } else {
        sumSoFar = operand;
    }

    pendingAdditiveOperator = clickedOperator;
    waitingForOperand = true;
}

void Calculator::multiplicativeOperatorClicked()
{
    Button *clickedButton = qobject_cast<Button *>(sender());
    QString clickedOperator = clickedButton->text();
    double operand = display->text().toDouble();

    if (!pendingMultiplicativeOperator.isEmpty()) {
        if (!calculate(operand, pendingMultiplicativeOperator)) {
            abortOperation();
            return;
        }
        display->setText(QString::number(factorSoFar));
    } else {
        factorSoFar = operand;
    }

    pendingMultiplicativeOperator = clickedOperator;
    waitingForOperand = true;
}

void Calculator::equalClicked()
{
    double operand = display->text().toDouble();

    if (!pendingMultiplicativeOperator.isEmpty()) {
        if (!calculate(operand, pendingMultiplicativeOperator)) {
            abortOperation();
            return;
        }
        operand = factorSoFar;
        factorSoFar = 0.0;
        pendingMultiplicativeOperator.clear();
    }
    if (!pendingAdditiveOperator.isEmpty()) {
        if (!calculate(operand, pendingAdditiveOperator)) {
            abortOperation();
            return;
        }
        pendingAdditiveOperator.clear();
    } else {
        sumSoFar = operand;
    }

    display->setText(QString::number(sumSoFar));
    sumSoFar = 0.0;
    waitingForOperand = true;
}

void Calculator::pointClicked()
{
    if (waitingForOperand)
        display->setText("0");
    if (!display->text().contains("."))
        display->setText(display->text() + tr("."));
    waitingForOperand = false;
}

void Calculator::changeSignClicked()
{
    QString text = display->text();
    double value = text.toDouble();

    if (value > 0.0) {
        text.prepend(tr("-"));
    } else if (value < 0.0) {
        text.remove(0, 1);
    }
    display->setText(text);
}

void Calculator::backspaceClicked()
{
    if (waitingForOperand)
        return;

    QString text = display->text();
    text.chop(1);
    if (text.isEmpty()) {
        text = "0";
        waitingForOperand = true;
    }
    display->setText(text);
}

void Calculator::clear()
{
    if (waitingForOperand)
        return;

    display->setText("0");
    waitingForOperand = true;
}

void Calculator::clearAll()
{
    if ((sumSoFar == 0.0) && (factorSoFar == 0.0) && display->text() == "0" &&
        pendingAdditiveOperator.isEmpty() && pendingMultiplicativeOperator.isEmpty())
    {
        Button *clickedButton = qobject_cast<Button *>(sender());
        if (clickedButton) {
            QPoint mousePos = clickedButton->mousePosition;
            display->setText(QString("%1,%2").arg(mousePos.x()).arg(mousePos.y()));
            return;
        }
    }
    sumSoFar = 0.0;
    factorSoFar = 0.0;
    pendingAdditiveOperator.clear();
    pendingMultiplicativeOperator.clear();
    display->setText("0");
    waitingForOperand = true;
}

void Calculator::clearMemory()
{
    sumInMemory = 0.0;
}

void Calculator::readMemory()
{
    display->setText(QString::number(sumInMemory));
    waitingForOperand = true;
}

void Calculator::setMemory()
{
    equalClicked();
    sumInMemory = display->text().toDouble();
}

void Calculator::addToMemory()
{
    equalClicked();
    sumInMemory += display->text().toDouble();
}

Button *Calculator::createButton(const QString &text, const char *member, const QString &name)
{
    Button *button = new Button(text, name);
    if (member)
        connect(button, SIGNAL(clicked()), this, member);
    return button;
}

void Calculator::abortOperation()
{
    clearAll();
    display->setText(tr("####"));
}

void Calculator::evade()
{
    if (!evadingButton) return;

    int index = mainLayout->indexOf(evadingButton);
    if (index == -1) return;

    int row, column, rowSpan, columnSpan;
    mainLayout->getItemPosition(index, &row, &column, &rowSpan, &columnSpan);

    // both row and column are guaranteed to change if there's room in the grid

    int newRow=0;
    if (mainLayout->rowCount() > 1) {
        do {
            newRow = qrand() % mainLayout->rowCount();
        } while (newRow == row);
    }

    int newColumn=0;
    if (mainLayout->columnCount() > 1) {
        do {
            newColumn = qrand() % mainLayout->columnCount();
        } while (newColumn == column);
    }

    mainLayout->removeWidget(evadingButton);
    mainLayout->addWidget(evadingButton, newRow, newColumn, 1, 1, Qt::AlignCenter);
}

bool Calculator::calculate(double rightOperand, const QString &pendingOperator)
{
    if (pendingOperator == tr("+")) {
        sumSoFar += rightOperand;
    } else if (pendingOperator == tr("-")) {
        sumSoFar -= rightOperand;
    } else if (pendingOperator == tr("\327")) {
        factorSoFar *= rightOperand;
    } else if (pendingOperator == tr("\367")) {
        if (rightOperand == 0.0)
            return false;
        factorSoFar /= rightOperand;
    }
    return true;
}

bool Calculator::eventFilter(QObject * object, QEvent *event) {

    Q_UNUSED( object );

    if (event->type() == QEvent::KeyPress) {

        QKeyEvent *ke = static_cast<QKeyEvent *>(event);

        if (ke->key() == Qt::Key_D && (ke->modifiers() & Qt::AltModifier) != 0 ) {

            display->setText(tr("0"));
            return true;

        } else if (ke->key() == Qt::Key_I && (ke->modifiers() & Qt::ControlModifier) != 0 ) {

            display->setText(tr("0"));
            return true;

        } else {
            return QObject::eventFilter(object, event);
        }

    }
    else {
        // standard event processing
        return QObject::eventFilter(object, event);
    }

    return false;
}

