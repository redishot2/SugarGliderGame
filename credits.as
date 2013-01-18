package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.Event;
	
	// This is the credits screen
	// This screen shows the user the credits
	// mostly my name. Any sounds or images that I used from 3rd parties
	// Features a button for main screen
	public class credits extends MovieClip {
		
		public var cre:CreditMC;
		public var ma:ButtonMain;
		
		public function credits() {
			// constructor code
		}
		
		// Set Up
		public function setUp()
		{
			// Add the bg
			cre = new CreditMC();
			this.addChild(cre);
			cre.x = -3;
			cre.y = -3;
			
			// Add the button for main screen
			ma = new ButtonMain();
			this.addChild(ma);
			ma.x = 40;
			ma.y = 335;
			
			// Event listeners
				// Buttons
					// Main
			ma.addEventListener(MouseEvent.MOUSE_OVER, bmOver);
			ma.addEventListener(MouseEvent.ROLL_OUT, bmOut);
			ma.addEventListener(MouseEvent.MOUSE_DOWN, bmDown);
			ma.addEventListener(MouseEvent.CLICK, bmClick);
		}
		
		// Methods for event listeners
			// Buttons
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
			
			// Remove event listeners
				// Main
			ma.removeEventListener(MouseEvent.MOUSE_OVER, bmOver);
			ma.removeEventListener(MouseEvent.ROLL_OUT, bmOut);
			ma.removeEventListener(MouseEvent.MOUSE_DOWN, bmDown);
			ma.removeEventListener(MouseEvent.CLICK, bmClick);
			
			// Change to the Game Screen
			MovieClip(root).clearCredits(1);
		}

	}
	
}
