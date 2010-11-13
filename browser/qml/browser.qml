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

import Qt 4.7
import QtWebKit 1.0

Rectangle {
   id:browser
   width:480
   height:800

   Rectangle {
      id:filler
      width:browser.width
      height:browser.height-controlbar.height

      Rectangle {
         id:addressbar;
         anchors.top:parent.top;

         width:parent.width
         height:browser.height/20
         color:"black"

         TextInput {
            id:urltext;
            text:webpage.url;
            color:"white"
            selectByMouse:true;

            x:0;
            y:0;
            width:parent.width-urlbutton.width
         }
         Rectangle {
            color:"cyan"
            id:urlbutton

            width:parent.height
            height:parent.height

            x:urltext.width
            MouseArea {
               anchors.fill:parent
               onClicked:{
                  webpage.url=urltext.text;
                  parent.x = urltext.width;
               }

               //clear gesture
               drag.target: urlbutton
               drag.axis: Drag.XAxis
               drag.minimumX: 0
               drag.maximumX: browser.width - parent.width
               onPressed: {urlbutton.color="gray";
                           urlbutton.opacity=0.50;}
               onReleased:{
                  parent.opacity=1.00;
                  if(parent.x < parent.parent.width/2){
                     urltext.text = "http://";
                     urltext.x=parent.width;
                     urltext.focus=true;
                     urlbutton.x=0
                  }
                  if(parent.x > parent.parent.width/2){
                     webpage.url = urltext.text;
                     parent.color="red";
                     parent.x = urltext.width;
                     urltext.x=0;
                  }
               }
            }
         }
      }
      Flickable {
         id:flickarea
         anchors.top:addressbar.bottom
         anchors.bottom:parent.bottom
         width:parent.width

         contentHeight:webpage.contentsSize.height
         contentWidth:webpage.contentsSize.width

         WebView {
            anchors.fill:parent;
            id:webpage;
            settings.autoLoadImages:true;
            settings.javascriptEnabled:true;

            preferredHeight:height;
            preferredWidth:width;

            url:"../html/test1.html"

            onLoadFinished: {
               flickarea.contentHeight=webpage.contentsSize.height;
               flickarea.contentWidth=webpage.contentsSize.width;
               urlbutton.color="cyan";
               urltext.text=url
            }
         }
      }
   }
   Rectangle {
      id:controlbar

      height:browser.height/20
      width:parent.width
      anchors.bottom:parent.bottom;

      color:"black";
      Rectangle {
         id:switcher

         width:parent.height-2
         height:parent.height-2

         x:(parent.width-width)/2;
         y:1

         MouseArea {
            anchors.fill: parent
            drag.target: switcher
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: browser.width - parent.width

            onPressed: {switcher.color="gray";}
            onReleased:{
               switcher.color="white";
               if(switcher.x < switcher.parent.width/3){
                  webpage.back.trigger();
               }
               if(switcher.x > 2*switcher.parent.width/3){
                  urltext.text = "http://";
               }
               var target = (switcher.parent.width-switcher.width)/2;
               switcher.x = target;
            }
         }
      }
   }
}
