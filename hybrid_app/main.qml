import Qt 4.7

Rectangle {
    id: box
    width: 360; height: 540

	Rectangle {
	    z: 1
	    id: buttonArea
	    width: 360; height: 270

	    Rectangle {
    	    id: redSquare
		    objectName: "Click"

	        width: 80; height: 80
	        anchors.top: parent.top; anchors.left: parent.left; anchors.margins: 10
	        color: "red"

	        Text { text: "Click"; font.pixelSize: 16; anchors.centerIn: parent }

    	    MouseArea {
	            anchors.fill: parent 
	            hoverEnabled: true
	            acceptedButtons: Qt.LeftButton | Qt.RightButton
	            onPressed:{ 
						info.text = 'Pressed' 
						parent.color = "blue"
				}
	            onReleased: {
					info.text = 'Released'  
					parent.color = "red"
                    greenSquare.opacity = greenSquare.opacity == 0
				}
	            onPressAndHold: info.text = 'Press and hold'
	        }
	    }


      Rectangle {
    	    id: greenSquare
		    objectName: "Visible"
            x: 20 ; y: 100
	        width: 80; height: 80
            opacity: 0
	        color: "green"
	        anchors.left: parent.left; anchors.margins: 10
	        Text { text: "Visible"; font.pixelSize: 16; anchors.centerIn: parent }
	    }


	    Rectangle {
		    z: 2
	        id: orangeSquare
	        width: 80; height: 80
	        x: box.width - width - 10; y: 10    // making this item draggable, so don't use anchors
	        color: "orange"
	
	        objectName: "Drag"	
	
	        Text { text: "Drag"; font.pixelSize: 16; color: "white"; anchors.centerIn: parent }
	
	        MouseArea {
	            anchors.fill: parent
	            drag.target: orangeSquare
	            drag.axis: Drag.XandYAxis
	            drag.minimumX: 0
	            drag.maximumX: box.width - parent.width
	            drag.minimumY: 0
	            drag.maximumY: box.height - parent.width
	
	            onPressed:{ 
	   			    parent.color = "green"
				}
	            onReleased: {
					parent.color = "orange"
				}
	
	        }
	    }
    	Text {
        	id: info
	    	objectName: "buttonText"
        	anchors.verticalCenter: parent.verticalCenter; anchors.horizontalCenter: parent.horizontalCenter; anchors.margins: 30
        	onTextChanged: console.log(text)
    	}
	}
    Rectangle {
		z: 0
		objectName: "ListArea"
     	width: 360; height: 270
    	anchors.top: parent.verticalCenter; anchors.left: parent.left
    	color: "lightgray"

     	Component {
        	id: contactDelegate
         	Item {
            	width: 360; height: 40
				objectName : itemIndex
             	Column {
                	Text { text: '<b>Title:</b> ' + value }
             	}
  		        MouseArea { 
					anchors.fill: parent 
					onClicked: listView.currentIndex  = index
				}
         	}
     	}
	
		Component {
        	id: highlightBar
         	Rectangle {
				objectName: "highlightBar"
            	width: 360; height: 40
				color: "lightsteelblue"
			    radius: 5 
             	y: listView.currentItem.y;
         	}
     	}	

     	ListView {
			id: listView
			objectName: "ContactList"
			flickDeceleration: 100
	        anchors.fill: parent
	        model: listModel
	        delegate: contactDelegate
	        highlight: highlightBar
			highlightFollowsCurrentItem: false
	        focus: true			
	    }

		ListModel {
			id: listModel
 		}	

		Component.onCompleted: addItemsToList()			
		function addItemsToList() {
			for(var i = 0 ; i < 1000; i++){
				listModel.append({value: "List item number: " + i, itemIndex: i})
			}
			listModel.sync
		}
	}
}



