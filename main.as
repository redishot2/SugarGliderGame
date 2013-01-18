package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.Event;
	
	// This is the main class
	// This class is the welcome screen
	// Features buttons for howTo, credits and game screens
	public class main extends MovieClip {
		
		// Variables
			// Buttons
		public var bPla:ButtonPlay;
		public var bCon:ButtonControls;
		public var bCre:ButtonCredits;
			// Title
		public var titl:Title;
		
		
		public function main() {
			// constructor code
		}
		
		// Set Up
		public function setUp()
		{
			// Add everything to the screen
				// Buttons
					// Play
			bPla = new ButtonPlay();
			this.addChild(bPla);
			bPla.x = 162;
			bPla.y = 237;
					// Controls
			bCon = new ButtonControls();
			this.addChild(bCon);
			bCon.x = 55;
			bCon.y = 328;
					// Credits
			bCre = new ButtonCredits();
			this.addChild(bCre);
			bCre.x = 348;
			bCre.y = 317;
				// Title
			titl = new Title();
			this.addChild(titl);
			titl.x = 26;
			titl.y = 21;
			
			
			// Add the event listeners
				// Buttons
					// Play
			bPla.addEventListener(MouseEvent.MOUSE_OVER, bpOver);
			bPla.addEventListener(MouseEvent.ROLL_OUT, bpOut);
			bPla.addEventListener(MouseEvent.MOUSE_DOWN, bpDown);
			bPla.addEventListener(MouseEvent.CLICK, bpClick);
					// Controls
			bCon.addEventListener(MouseEvent.CLICK, bcClick);
			bCon.addEventListener(MouseEvent.MOUSE_DOWN, bcDown);
			bCon.addEventListener(MouseEvent.ROLL_OUT, bcOut);
			bCon.addEventListener(MouseEvent.MOUSE_OVER, bcOver);
					// Credits
			bCre.addEventListener(MouseEvent.CLICK, brClick);
			bCre.addEventListener(MouseEvent.MOUSE_DOWN, brDown);
			bCre.addEventListener(MouseEvent.MOUSE_OUT, brOut);
			bCre.addEventListener(MouseEvent.MOUSE_OVER, brOver);
		}
		
		// Event listener methods
			// Buttons
				// Play (bp)
		public function bpOver(e:Event):void
		{ 	bPla.gotoAndStop("Hover"); 		}
		public function bpDown(e:Event):void
		{ 	bPla.gotoAndStop("Click"); 		}
		public function bpOut(e:Event):void
		{	bPla.gotoAndStop("Static");		}
		public function bpClick(e:Event):void
		{ 	
			bPla.gotoAndStop("Hover");
			
			// Change to the Game Screen
			clearThisMain(5);
		}
				// Controls (bc)
		public function bcOver(e:Event):void
		{ 	bCon.gotoAndPlay("Hover"); 		}
		public function bcDown(e:Event):void
		{ 	bCon.gotoAndPlay("Click"); 		}
		public function bcOut(e:Event):void
		{ 	bCon.gotoAndPlay("Static"); 	}
		public function bcClick(e:Event):void
		{
			bCon.gotoAndPlay("Hover");
			
			// Change to Control Screen
			clearThisMain(2);
		}
				// Credits (br)
		public function brOver(e:Event):void
		{ 	bCre.gotoAndPlay("Hover"); 		}
		public function brDown(e:Event):void
		{ 	bCre.gotoAndPlay("Click"); 	 	}
		public function brOut(e:Event):void
		{ 	bCre.gotoAndPlay("Static"); 	}
		public function brClick(e:Event):void
		{
			bCre.gotoAndPlay("Hover");
			
			// Change to the credits screen
			clearThisMain(3);
		}
		
		public function clearThisMain(n:Number):void
		{
			// Remove event listeners
				// Buttons
					// Play
			bPla.removeEventListener(MouseEvent.MOUSE_OVER, bpOver);
			bPla.removeEventListener(MouseEvent.ROLL_OUT, bpOut);
			bPla.removeEventListener(MouseEvent.MOUSE_DOWN, bpDown);
			bPla.removeEventListener(MouseEvent.CLICK, bpClick);
					// Controls
			bCon.removeEventListener(MouseEvent.CLICK, bcClick);
			bCon.removeEventListener(MouseEvent.MOUSE_DOWN, bcDown);
			bCon.removeEventListener(MouseEvent.ROLL_OUT, bcOut);
			bCon.removeEventListener(MouseEvent.MOUSE_OVER, bcOver);
					// Credits
			bCre.removeEventListener(MouseEvent.CLICK, brClick);
			bCre.removeEventListener(MouseEvent.MOUSE_DOWN, brDown);
			bCre.removeEventListener(MouseEvent.MOUSE_OUT, brOut);
			bCre.removeEventListener(MouseEvent.MOUSE_OVER, brOver);
			
			MovieClip(root).clearMain(n);
		}
	}
	
}
