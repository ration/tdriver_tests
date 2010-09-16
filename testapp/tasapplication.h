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
*  Name        : tasapplication.h
*  Part of     : Test application
*  Description : Test application application 
*  Version     : %version: %
*
*  Copyright © 2009 Nokia.  All rights reserved.
*  This material, including documentation and any related computer
*  programs, is protected by copyright controlled by Nokia.  All
*  rights are reserved.  Copying, including reproducing, storing,
*  adapting or translating, any or all of this material requires the
*  prior written consent of Nokia.  This material also contains
*  confidential information which may not be disclosed to others
*  without the prior written consent of Nokia.
*  ===========================================================================
*/


#ifndef TASAPPLICATION_H
#define TASAPPLICATION_H

#include <QApplication>

class TasApplication : public QApplication
{
    Q_OBJECT
public:  
    TasApplication(int & argc, char ** argv);
	~TasApplication();
    int launch();

	static void exit ( int returnCode = 0 );

public slots:
	void quit();
    void emitPerfMeasurement(const QString& id);

signals:
    void applicationReady();
    void perfMeasurement(const QString&);
};

#endif
