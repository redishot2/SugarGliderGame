package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.Event;
	
	// This is the lose screen
	// This screen shows the player that they have lost the game
	// score, retry, dead sugar? are displayed
	// Features buttons for game and main screen
	public class lose extends MovieClip {
		
		// Attributes
		public var bg:Lost;
		public var score:Score;
		public var bMain:ButtonMain;
		public var bPlay:ButtonPlayH;
		
		public function lose() { }
		
		// Set Up
		public function setUp(finalScore:Number)
		{
			// BG
			bg = new Lost();
			bg.x = 0;
			bg.y = 0;
			this.addChild(bg);
			
			// Score
			score = new Score(finalScore);
			score.x = 50;
			score.y = 200;
			this.addChild(score);

			// Play again button
			bPlay = new ButtonPlayH();
			this.addChild(bPlay);
			bPlay.x = 50;
			bPlay.y = 300;
			
			// Main screen button
			bMain = new ButtonMain();
			this.addChild(bMain);
			bMain.x = 340;
			bMain.y = 300;
			
			// Event listeners
				// Play
			bPlay.addEventListener(MouseEvent.MOUSE_DOWN, pDown);
			bPlay.addEventListener(MouseEvent.CLICK, pClick);
			bPlay.addEventListener(MouseEvent.MOUSE_OVER, pHover);
			bPlay.addEventListener(MouseEvent.ROLL_OUT, pOut);
				// Main
			bMain.addEventListener(MouseEvent.MOUSE_OVER, bmOver);
			bMain.addEventListener(MouseEvent.ROLL_OUT, bmOut);
			bMain.addEventListener(MouseEvent.MOUSE_DOWN, bmDown);
			bMain.addEventListener(MouseEvent.CLICK, bmClick);
		}
		
		// Event listener methods
			// Play
		public function pHover(e:Event):void
		{ 	bPlay.gotoAndStop("Hover"); 		}
		public function pDown(e:Event):void
		{ 	bPlay.gotoAndStop("Click"); 		}
		public function pOut(e:Event):void
		{	bPlay.gotoAndStop("Static");		}
		public function pClick(e:Event):void
		{ 	
			bPlay.gotoAndStop("Hover");
			
			// Make a new Game Screen
			clearThisScreen(5);
		}
			// Main
		public function bmOver(e:Event):void
		{ 	bMain.gotoAndStop("Hover"); 		}
		public function bmDown(e:Event):void
		{ 	bMain.gotoAndStop("Click"); 		}
		public function bmOut(e:Event):void
		{	bMain.gotoAndStop("Static");		}
		public function bmClick(e:Event):void
		{ 	
			bMain.gotoAndStop("Hover");
			
			// Change to the Game Screen
			clearThisScreen(1);
		}
		
		// Clear this screen
		public function clearThisScreen(num:int)
		{
			// Remove event listeners
				// Play
			bPlay.removeEventListener(MouseEvent.MOUSE_DOWN, pDown);
			bPlay.removeEventListener(MouseEvent.CLICK, pClick);
			bPlay.removeEventListener(MouseEvent.MOUSE_OVER, pHover);
			bPlay.removeEventListener(MouseEvent.ROLL_OUT, pOut);
				// Main
			bMain.removeEventListener(MouseEvent.MOUSE_OVER, bmOver);
			bMain.removeEventListener(MouseEvent.ROLL_OUT, bmOut);
			bMain.removeEventListener(MouseEvent.MOUSE_DOWN, bmDown);
			bMain.removeEventListener(MouseEvent.CLICK, bmClick);
			
			MovieClip(root).clearLose(num);
		}
	}
	
}
