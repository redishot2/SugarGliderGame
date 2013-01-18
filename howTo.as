package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.Event;
	
	// This is the how-to screen
	// This screen tells the user how to play the game
	// goals, controls, etc.
	// Features buttons for main and game screens
	public class howTo extends MovieClip {
		
		public var howt:HowToPlay;
		public var pl:ButtonPlayH;
		public var ma:ButtonMain;
		
		public function howTo() {
			// constructor code
		}
		
		// Set Up
		public function setUp()
		{
			// Add the picture
			howt = new HowToPlay();
			this.addChild(howt);
			howt.x = -3;
			howt.y = -3;
			
			// Add the button for main and play
				// Play
			pl = new ButtonPlayH();
			this.addChild(pl);
			pl.x = 400;
			pl.y = 335;
				// Main
			ma = new ButtonMain();
			this.addChild(ma);
			ma.x = 40;
			ma.y = 335;
			
			// Event listeners
				// Buttons
					// Play
			pl.addEventListener(MouseEvent.MOUSE_OVER, bpOver);
			pl.addEventListener(MouseEvent.ROLL_OUT, bpOut);
			pl.addEventListener(MouseEvent.MOUSE_DOWN, bpDown);
			pl.addEventListener(MouseEvent.CLICK, bpClick);
					// Main
			ma.addEventListener(MouseEvent.MOUSE_OVER, bmOver);
			ma.addEventListener(MouseEvent.ROLL_OUT, bmOut);
			ma.addEventListener(MouseEvent.MOUSE_DOWN, bmDown);
			ma.addEventListener(MouseEvent.CLICK, bmClick);
		}
		
		// Methods for the event listeners
			// Buttons
				// Play (bp)
		public function bpOver(e:Event):void
		{ 	pl.gotoAndStop("Hover"); 		}
		public function bpDown(e:Event):void
		{ 	pl.gotoAndStop("Click"); 		}
		public function bpOut(e:Event):void
		{	pl.gotoAndStop("Static");		}
		public function bpClick(e:Event):void
		{ 	
			pl.gotoAndStop("Hover");
			
			// Change to the Game Screen
			clearThisScreen(5);
		}
				// Main (bm)
		public function bmOver(e:Event):void
		{ 	ma.gotoAndStop("Hover"); 		}
		public function bmDown(e:Event):void
		{ 	ma.gotoAndStop("Click"); 		}
		public function bmOut(e:Event):void
		{	ma.gotoAndStop("Static");		}
		public function bmClick(e:Event):void
		{ 	
			ma.gotoAndStop("Hover");
			
			// Change to the Game Screen
			clearThisScreen(1);
		}
		
		public function clearThisScreen(n:Number)
		{
			// Remove event listener
				// Buttons
					// Play
			pl.removeEventListener(MouseEvent.MOUSE_OVER, bpOver);
			pl.removeEventListener(MouseEvent.ROLL_OUT, bpOut);
			pl.removeEventListener(MouseEvent.MOUSE_DOWN, bpDown);
			pl.removeEventListener(MouseEvent.CLICK, bpClick);
					// Main
			ma.removeEventListener(MouseEvent.MOUSE_OVER, bmOver);
			ma.removeEventListener(MouseEvent.ROLL_OUT, bmOut);
			ma.removeEventListener(MouseEvent.MOUSE_DOWN, bmDown);
			ma.removeEventListener(MouseEvent.CLICK, bmClick);
			
			MovieClip(root).clearHowTo(n);
		}
		
	}
	
}
