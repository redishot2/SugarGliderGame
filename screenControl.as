package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	// The function of this class is to change the screens
	// main, credits, lost, how to, game
	public class screenControl extends MovieClip {
		
		// Screen variables
		public var mSc:main;
		public var hSc:howTo;
		public var cSc:credits;
		public var lSc:lose;
		public var gSc:game;
		public var bgMusic:music;
		
		public function screenControl() {
			// Make sure to start with the main screen
			setUpMain();
			bgMusic = new music();
			bgMusic.play();
		}
		
		// Methods to set up the different screens
			// Main
		public function setUpMain():void
		{
			mSc = new main();
			this.addChild(mSc);
			mSc.setUp();
		}
			// How To
		public function setUpHowTo():void
		{
			hSc = new howTo();
			this.addChild(hSc);
			hSc.setUp();
		}
			// Credits
		public function setUpCredits():void
		{
			cSc = new credits();
			this.addChild(cSc);
			cSc.setUp();
		}
			// Lost
		public function setUpLose(finalScore:Number):void
		{
			lSc = new lose();
			this.addChild(lSc);
			lSc.setUp(finalScore);
		}
			// Game
		public function setUpGame():void
		{
			gSc = new game();
			this.addChild(gSc);
			gSc.setUp();
		}
		
		
		// Clear the screen so you can have a fresh start
			// 1 - Go to main
			// 2 - Go to howTo
			// 3 - Go to credits
			// 4 - Go to lose
			// 5 - Go to game
		
			// Main
		public function clearMain(goto:Number):void
		{
			this.removeChild(mSc);
			
			// Decide which screen is next
			if(goto == 2)
			{
				// HowTo
				setUpHowTo();
			}
			else if(goto == 3)
			{
				// Credits
				setUpCredits();
			}
			else if(goto == 5)
			{
				// Game
				setUpGame();
			}
		}
			// How to
		public function clearHowTo(goto:Number):void
		{
			this.removeChild(hSc);
			
			// Decide which screen is next
			if(goto === 1)
			{
				// Main
				setUpMain();
			}
			else if(goto === 2)
			{
				// HowTo
				setUpHowTo();
			}
			else if(goto === 3)
			{
				// Credits
				setUpCredits();
			}
			else if(goto === 5)
			{
				// Game
				setUpGame();
			}
		}
			// Credits
		public function clearCredits(goto:Number):void
		{
			this.removeChild(cSc);
			
			// Decide which screen is next
			if(goto === 1)
			{
				// Main
				setUpMain();
			}
			else if(goto === 2)
			{
				// HowTo
				setUpHowTo();
			}
			else if(goto === 3)
			{
				// Credits
				setUpCredits();
			}
			else if(goto === 5)
			{
				// Game
				setUpGame();
			}
		}
			// Lost
		public function clearLose(goto:Number):void
		{
			this.removeChild(lSc);
			
			// Decide which screen is next
			if(goto === 1)
			{
				// Main
				setUpMain();
			}
			else if(goto === 2)
			{
				// HowTo
				setUpHowTo();
			}
			else if(goto === 3)
			{
				// Credits
				setUpCredits();
			}
			else if(goto === 5)
			{
				// Game
				setUpGame();
			}
		}
			// Game
		public function clearGame(goto:Number, finalScore:Number):void
		{
			this.removeChild(gSc);
			
			// Decide which screen is next
			if(goto === 1)
			{
				// Main
				setUpMain();
			}
			else if(goto === 4)
			{
				// Lose
				setUpLose(finalScore);
			}
			else if(goto === 5)
			{
				// Game
				setUpGame();
			}
		}
	}
	
}
