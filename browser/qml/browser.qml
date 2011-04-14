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
   width:100
   height:100

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
            objectName: "urltext";
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
            objectName: "urlbutton";

            width:parent.height
            height:parent.height

            x:urltext.width
            MouseArea {
               anchors.horizontalCenter: parent.horizontalCenter
               anchors.verticalCenter: parent.verticalCenter
               width: (parent.width)*2
               height: (parent.height)*2
               onClicked:{
                  webpage.url=urltext.text;
                  parent.x = urltext.width;
               }

               drag.target: urlbutton
               drag.axis: Drag.XAxis
               drag.minimumX: 0
               drag.maximumX: browser.width - parent.width
               onPressed: {
                  urlbutton.opacity=0.5;
                  //addressbar.state="drag";
               }
               onReleased:{
                  if(parent.x < parent.parent.width/2){
                     urltext.text = "";
                     urltext.focus=true;
                     addressbar.state="type"
                  }
                  if(parent.x > parent.parent.width/2){
                     webpage.url = urltext.text;
                     addressbar.state="load"
                  }
               }
            }
         }
         states:[
            State {
               name: "drag";
               PropertyChanges { target: urlbutton; opacity:0.50;}
            },
            State {
               name: "type";
               PropertyChanges { target: urltext; x:urlbutton.width; y:0; }
               PropertyChanges { target: urlbutton; x:0; y:0; opacity:1.00;}
            },
            State {
               name: "load";
               PropertyChanges { target: urlbutton; x: urltext.width; opacity:1.00; color:"red";}
               PropertyChanges { target: urltext; x: 0; }
            },
            State {
               name: "ready"
               PropertyChanges { target: urlbutton; color:"cyan"; opacity:1.00; }
            }
         ]
         transitions: [
            Transition {
               from: "*"; to: "*";
               //SequentialAnimation {
               NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuart ;duration:400}
               NumberAnimation { properties: "opacity"; easing.type: Easing.InOutQuart; duration:400}
                  ColorAnimation { duration: 1000 }
               //}
            }
         ]

      }
//      Flickable {
      Rectangle {
         id:flickarea
         anchors.top:addressbar.bottom
         anchors.bottom:parent.bottom
         width:parent.width

         //contentHeight:webpage.contentsSize.height
         //contentWidth:webpage.contentsSize.width

         WebView {
            anchors.fill:parent;
            id:webpage;
            settings.autoLoadImages:true;
            settings.javascriptEnabled:true;

            preferredHeight:height;
            preferredWidth:width;

            url:"../html/testpage.html"

            onLoadFinished: {
               //flickarea.contentHeight=webpage.contentsSize.height;
               //flickarea.contentWidth=webpage.contentsSize.width;
               addressbar.state="ready";
               urltext.text=url
            }
            onLoadStarted: {
               addressbar.state="load"
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
         objectName:"bottom_button"

         width:parent.height-2
         height:parent.height-2

         x:(parent.width-width)/2;
         y:1

         MouseArea {
            id:switcherMouseArea
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: (parent.width)*2
            height: (parent.height)*2
            drag.target: switcher
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: browser.width - parent.width

            onPressed: {
               switcher.color="gray";
               parent.state="dragging"
            }
            onReleased:{
               switcher.color="white";
               if(switcher.x < switcher.parent.width/3){
                  webpage.back.trigger();

               }
               if(switcher.x > 2*switcher.parent.width/3){
                  parent.state="locked"
                  flickarea.flickableDirection=Flickable.VerticalFlick;
               } else {
                   parent.state="released"
                  flickarea.flickableDirection=Flickable.HorizontalAndVerticalFlick;
               }
            }
         }

         states: [
            State {
               name: "dragging";
               PropertyChanges { target: switcher; color:"gray"; }
            },
            State {
               name: "released";
               PropertyChanges { target: switcher; x: (switcher.parent.width-switcher.width)/2; }
            },
            State {
               name: "locked";
               PropertyChanges { target: switcher; x: (switcher.parent.width-switcher.width); }
            }
         ]


         transitions: Transition {
            from:"*";to:"*";
            NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuart }
         }
      }
   }
}
