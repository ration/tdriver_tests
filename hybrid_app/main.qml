import Qt 4.7

Rectangle {
    id: box
    width: 360; height: 540

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
			}
            onPressAndHold: info.text = 'Press and hold'
        }
    }

    Rectangle {
        id: blueSquare
        width: 80; height: 80
        x: box.width - width - 10; y: 10    // making this item draggable, so don't use anchors
        color: "orange"

        objectName: "Drag"	

        Text { text: "Drag"; font.pixelSize: 16; color: "white"; anchors.centerIn: parent }

        MouseArea {
            anchors.fill: parent
            drag.target: blueSquare
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
