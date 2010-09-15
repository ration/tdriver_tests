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
 
 
/*
*  ===========================================================================
*  Name        : main.cpp
*  Part of     : Test application
*  Description : Test application main
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

#include <QtGui>
#include "tasapplication.h"

#include "mainwindow.h"

int main(int argc, char **argv)
{
    TasApplication app(argc, argv);
    qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));
   
#if !defined(QT_NO_LIBRARY)

    QLibrary testLib("qttestability");
    if(testLib.load()){
        typedef void (*TasInitialize)(void);
        TasInitialize initFunction = (TasInitialize)testLib.resolve("qt_testability_init");
#ifdef Q_OS_SYMBIAN
        //not found so use ordinal
        if(!initFunction){
            initFunction = (TasInitialize)testLib.resolve("1");
        }
#endif
        if(initFunction){
            //            TasLogger::logger()->debug("main: initialize found execute!");
            initFunction();
        }
    }
#endif
  
    MainWindow window;
    window.show();

    if(argc > 2 && QString(argv[1]) == QString("-n")){
        int nodes = QString(argv[2]).toInt();
        window.addNodes(nodes);    
    }
	if(argc > 2 && QString(argv[1]) == QString("-r")){
		QTimer::singleShot( QString(argv[2]).toInt()*1000, &app, SLOT(quit()) );
	}

    if(argc > 1 && QString(argv[1]) == QString("-d")){
        QTimer::singleShot(5000, &window, SLOT(openMenu()));
    }

    if(argc > 1 && QString(argv[1]) == QString("-c")){
        window.setCrashOnExit();
    }

    if(argc > 1 && QString(argv[1]) == QString("-s")){
        window.setCrashOnStart();
    }
    int code =  app.launch();
    if(argc > 1 && QString(argv[1]) == QString("-k")){
        code = app.exec();
    }
    return code;
}
