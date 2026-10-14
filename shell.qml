import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Widgets

Variants {
  model: Quickshell.screens;

  delegate: Component {
    PanelWindow {
      // the screen from the screens list will be injected into this
      // property
      required property var modelData

      // we can then set the window's screen to the injected property
      screen: modelData
      color: "#00000000"
      anchors {
        left: true
	top: true

	}
	margins {
		top:320
		left:50
		right: 0        
	}
aboveWindows: false
exclusionMode: "Ignore"


implicitHeight: 600
implicitWidth:600

	Image {
		x: 0
		y:0
		z:0
        	width: 3012*0.12
        	height: 1623*0.12
        	//fillMode: Image.Tile
        	source: "mp3.png"
    }
	Image {
		x: 22
		y:21
		z:-1
        	width: 147
        	height: 147
        	//fillMode: Image.Tile
        	source: "cover.png"
	}



	FileView {
		id: artistFile
		path:Qt.resolvedUrl("./artist.json")
	}
	readonly property var artistname: artistFile.text()

	FileView {
		id: titleFile
		path:Qt.resolvedUrl("./title.json")
		onFileChanged: this.reload()
	}
	property var title: titleFile.text()



	
	Rectangle{
		id:rectangletitle
		color:"#cd65c5"
		x:0
		y:200
		z:100
		height:30
		clip:true
		radius:15
		implicitWidth:titletext.implicitWidth+10
		Text{	
			id:titletext
			x:5
			y:7
			text:title	
			//font.weight: Font.DemiBold
			font.pixelSize:14
			font.family:"Courier Prime"
			style:Text.Outline;styleColor:"#ad4aa5"
			clip:true
			//color:"#ae4aa5"
		
		}
	}

	Rectangle{
		id:rectangleartist
		color:"#cd65c5"
		x:titletext.implicitWidth+20
		y:200
		z:100
		height:30
		clip:true
		radius:15
		implicitWidth:artisttext.implicitWidth+10
		Text {	
			

			id:artisttext
			x:5
			y:7
			text:artistname	
			font.pixelSize: 14
			font.weight: Font.DemiBold		
			font.family:"Courier Prime"
			style:Text.Outline;styleColor:"#ad4aa5"
			clip:true
			//color:"#ae4aa5"

		}
		Process {
      			// give the process object an id so we can talk
      			// about it from the timer
      			id: dateProc

			//command: ["sh", "-c",  > current_PID"]
      			running: true

      			
    }

	}




      
    }
  }
}


