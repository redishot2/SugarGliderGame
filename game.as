package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	// This is the game screen
	// This screen is where the player plays the game
	// Features key for pause (with button for main and restart)
	public class game extends MovieClip {
		
		// Attributes
		public var score:Number;
		public var scoreDisplay:Score;
			// Berry
		public var grouBerH:Number = 0;
		public var jumpBerH:Number = 0;
		public var berArray:Array;
		public var berPointVal:Number = 30;
			// Objs
		public var bg:BGGame;
		public var ber:Berry;
		public var sugar:SugarRunning;
		public var sugarJump:SugarFlyingSide = new SugarFlyingSide();
			// Trees
		public var trees1:Trees1;
		public var trees2:Trees1;
		public var branches:Array;
		public var screenBranches:Array;
			// Jump
		public var falling:Boolean;
		public var jumping:Boolean;
		public var canJump:Boolean;
		public var jumpLength:Number = 300;
		public var jumpSoFar:Number = 0;
		public var treeSpeed:Number = 20;
		public var jumpCount:Number = 0;
		public var jumpCap:Number = 10;
			// Shooters
		public var bullet:acorn;
		public var leaf:Leafs;
		public var leafArray:Array = new Array();
		public var bulArray:Array = new Array();
			// Pause
		public var ma:ButtonMain;
		public var pl:ButtonPlayH;
		public var pScreen:PauseScreen;
		
		public function game() {
			// constructor code
		}
		
		// Set Up
		public function setUp()
		{
			// Put all the things on the screen
				// BG
			bg = new BGGame();
			this.addChild(bg);
			
				// Trees 
					// Start
			trees1 = new Trees1();
			this.addChild(trees1);
			trees1.x = 50;
			trees1.y = -20;
					// Second trees (off screen)
			trees2 = new Trees1();
			this.addChild(trees2);
			trees2.x = 600;
			trees2.y = -20;
					
				// Branches (method)
					// Set up all branches in array
			screenBranches = new Array();
			branches = new Array();
			arrayBranches();
					// First branch
			var i:int;
			while((i = ranBranch()) == 1)
			{
				i = ranBranch();
			}
			this.addChild(branches[i]);
			screenBranches.push(branches[i]);
			branches.splice(i, 1);
					// Second branch
			var j:int = ranBranch();
			this.addChild(branches[j]);
			screenBranches.push(branches[j]);
			screenBranches[1].x = screenBranches[0].x + screenBranches[0].width + space();
			branches.splice(j, 1);
			
				// Sugar
					// Run
			sugar = new SugarRunning();
			this.addChild(sugar);
			sugar.x = 10;
			sugar.y = 100;
			sugar.scaleX = .4;
			sugar.scaleY = .4;
			
				// Berries (array)(method)
			berArray = new Array();
			berries();
			
				// Time/ score
			score = 0;
			
				// The score display
			scoreDisplay = new Score(score);
			this.addChild(scoreDisplay);
			
				// Make leafs
			makeLeafs();
			
			// Event listeners
				// Every frame
			this.addEventListener(Event.ENTER_FRAME, everyFrame);
				// Keyboard
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyD);
		}
		
		// Event listener methods
		public function everyFrame(e:Event):void
		{
			// Score update
				// Make the score incrament
			score += 1;
				// Update the score on the screen
			scoreDisplay.setScore(score);
			
			// Trees move left
			trees1.x -= 6;
			trees2.x -= 6;
			
			// Screen branches move left
			for(var i:int = 0; i < screenBranches.length; i++)
			{
				// Move the branches leftward
				screenBranches[i].x -= treeSpeed;
			}
			
			// See if need more bg trees
			ranTrees();
			
			// Physics 
			physics();
			
			// Method to make more ran branches
			needBranches();
			
			// See if lost game
			gameLost();
			
			// Jumping
			if(jumping && jumpCount < jumpCap)
			{
				jump();
			}
			
			// Berries
				// Put on screen (if the last berry is off screen)
			if(berArray.length > 0)
			{
				if(berArray[berArray.length - 1].x < 0)
				{
					berries();
				}
			}
				// Move across the screen
			berMove();
				// Check to see if sugar has collided
			hitBerry();
			
			// Move any screen acorns or leafs
			moveAcorns();
			moveLeafs();
			leafCollide(sugar);
			for(var j:int = 0; j < bulArray.length; j++)
			{
				leafCollide(bulArray[j]);
			}
		}
		
		// Keyboard e.l.
		public function keyD(e:KeyboardEvent):void
		{
			// Check to see which key is down
				// Up
			if(e.keyCode == Keyboard.UP)
			{
				// Jump
				jumping = true;
			}
				// P (pause)
			if(e.keyCode == Keyboard.P)
			{
				// Pause game
				pauseMenu();
			}
			if(e.keyCode == Keyboard.SPACE)
			{
				// Shoot acorn
				shootAcorn();
			}
		}
		
		public function pauseMenu()
		{
			// Pauses game
			// Remove the everyfram event listener
			this.removeEventListener(Event.ENTER_FRAME, everyFrame);
			
			// Show the pause screen on top of the old screen
			pScreen = new PauseScreen();
			this.addChild(pScreen);
			pScreen.x = 100;
			pScreen.y = 100;
			
			// Add buttons for resume and main
			ma = new ButtonMain();
			this.addChild(ma);
			ma.x = 130;
			ma.y = 220;
			
			pl = new ButtonPlayH();
			this.addChild(pl);
			pl.x = 290;
			pl.y = 220;
			
			// Add event listeners
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
			
			// Continue the game
			this.addEventListener(Event.ENTER_FRAME, everyFrame);
			
			// Remove the pause screen
			this.removeChild(pScreen);
			this.removeChild(pl);
			this.removeChild(ma);
			
			// End the event listeners
			endELPause();
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
			
			// Change to the main
			// End event listeners
				// Every frame
			this.removeEventListener(Event.ENTER_FRAME, everyFrame);
				// Keyboard
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyD);
			
			// He has fallen and thus lost the game
			MovieClip(root).clearGame(1, score);
		}
		
		public function shootAcorn()
		{
			// Use the y value of sugar for acorn
			bullet = new acorn();
			bullet.y = sugar.y;
			bullet.x = sugar.x + 200;
			bullet.scaleX = .3;
			bullet.scaleY = .3;
			bulArray.push(bullet);
			this.addChild(bullet);
		}
		
		public function moveAcorns()
		{
			// Loop through the bulArray
			for(var i:int = 0; i < bulArray.length; i++)
			{
				bulArray[i].x += 10;
				
				// See if left the screen
				if(bulArray[i].x > 550)
				{
					this.removeChild(bulArray[i]);
					bulArray.splice(i, 1);
					i--;
				}
			}
		}
		
		public function makeLeafs():void
		{
			if(leafArray.length < 3)
			{
				leaf = new Leafs();
				leaf.x = 550;
				leaf.y = sugar.y;
				leaf.scaleX = .2;
				leaf.scaleY = .2;
				leafArray.push(leaf);
				this.addChild(leaf);
			}
		}
		
		public function moveLeafs():void
		{
			for(var i:int = 0; i < leafArray.length; i++)
			{
				leafArray[i].x -= treeSpeed;
				
				// See it left the screen
				if(leafArray[i].x + leafArray[i].width < 0)
				{
					if(leafArray[i].parent != null)
					{
						this.removeChild(leafArray[i]);
					}
					leafArray.splice(i, 1);
					i--;
					
					// Make a new leaf
					makeLeafs();
				}
			}
		}
		
		public function leafCollide(obj:MovieClip):void
		{
			if(obj != null)
			{
				// Send in obj to check against leafs
				for(var i:int = 0; i < leafArray.length; i++)
				{
					if(obj.hitTestObject(leafArray[i]))
					{
						if(obj is SugarRunning)
						{
							// Obj is a sugar
							// Game over
							autoLose();
						}
						else if(obj is acorn)
						{
							// Obj is an acorn
							// Add to the score
							score += 30;
							
							// Remove the acorn and the leaf
							if(leafArray[i].parent != null)
							{
								this.removeChild(leafArray[i]);
							}
							leafArray.splice(i, 1);
							makeLeafs();
							if(obj.parent != null)
							{
								this.removeChild(obj);
							}
							bulArray.splice(bulArray.indexOf(obj), 1);
						}
					}
				}
			}
		}
		
		// Randomly generating branches method
		public function ranBranch():int
		{
			// Generates a number. Each number corrolates with a branch. Branch is displayed off screen (later to be moved onto screen)
			var ran:Number = Math.floor(Math.random() * branches.length);
			
			return ran;
		}
		
		// Randomly generating berries
		public function berries():void
		{
			// Can be at two locations: walk level and jump level
			// Randomly generate berries in clumps of 2-6
			
			// Call a method to get a ran num
			var numBer:int = berNum();
			
			// Use number to generate on either bottom or top (ran method)
			var berLoc:int = walkorjump();
			
			// Clear the array
			berArray = new Array();
			
			// Loop through the berNum and put on screen
			for( var i:int = 0; i < numBer; i++)
			{
				// Put on screen
				ber = new Berry();
				ber.scaleX = .5;
				ber.scaleY = .5;
				ber.y = berLoc;
				this.addChild(ber);
				berArray.push(ber);
				
				// Change the x to be lined up with the others
				if(i != 0)
				{
					ber.x = berArray[i - 1].x + 60;
				}
				else
				{
					ber.x = 440;
				}
			}
		}
		
		// Check to see if hit a berry
		public function hitBerry():void
		{
			// Loop through the berries
			for(var i:int = 0; i < berArray.length; i++)
			{
				// Check to see if sugar is in contact with the berries
				if(sugar.hitTestObject(berArray[i]) == true)
				{
					// Are colliding 
					// Up the score
					score += berPointVal;
					
					// Remove the berry
					this.removeChild(berArray[i]);
					berArray.splice(i, 1);
					i--;
				}
				if(berArray.length < 1)
				{
					// Empty array
					berries();
				}
			}
		}
		
		// Move the berries across the screen
		public function berMove():void
		{
			// Loop
			for(var i:int = 0; i < berArray.length; i++)
			{
				berArray[i].x -= treeSpeed;
			}
		}
		
		// Randomly generate jump or walk level
		public function walkorjump():Number
		{
			var num:Number = Math.random() * 2 + 1;
			
			if(num == 1)
			{
				return 300;
			}
			if(num == 2)
			{
				return 100;
			}
			return 100;
		}
		
		// Randomly generate number of berries
		public function berNum():Number
		{
			return Math.random() * 4 + 2;
		}
		
		// Randomly generating trees
		public function ranTrees():void
		{
			// Make trees circle around when the old reach the end of the screen
			if(trees1.x < -550)
			{
				newTrees(trees1);
			}
			else if(trees2.x < -550)
			{
				newTrees(trees2);
			}
		}
		// Trees
		public function newTrees(tree:Trees1):void
		{
			// Make new trees
			tree.x = 551;
		}
		
		// Jump 
		public function jump():void
		{
			// Change to jump
			sugarToJump();
			
			// If jumping and falling are both false
			// And is allowed to jump
			if(falling == false)
			{
				// allowed to jump
				canJump = true;
			}
			
			if(canJump)
			{
				// Make him go upwards
				if(jumpSoFar < jumpLength)
				{
					sugar.y -= 30;
					jumpSoFar += 30;
				}
				
				// The jump is done
				else
				{
					// Reset
					jumping = false;
					jumpSoFar = 0;
				}
			}
			
			// Increment the jump count
			jumpCount++;
		}
		
		public function sugarToJump():void
		{
			// Change the sugar to jump
			sugarJump.x = sugar.x;
			sugarJump.y = sugar.y;
			sugarJump.scaleX = sugar.scaleX;
			sugarJump.scaleY = sugar.scaleY;
			if(sugar.parent != null)
			{
				this.removeChild(sugar);
				this.addChild(sugarJump);
			}
		}
		public function jumpToSugar():void
		{
			// Change sugar back to run
			if(sugarJump.parent != null)
			{
				this.removeChild(sugarJump);
				this.addChild(sugar);
			}
		}
		
		// Physics
		public function physics():void
		{
			var fallCount:int = 0;
			
			// Check to see if sugar is connecting with branches (loop)
			for(var i:int = 0; i < screenBranches.length; i++)
			{
				if(screenBranches[i].parent != null && screenBranches[i].hitTestPoint(sugar.x + 150, sugar.y + 80, true))
				{
					// Hiting a branch
					fallCount++;
				}
			}
			
			if(fallCount == 0)
			{
				// The counter is equal to the length of the branches 
				// Sugar is connecting to none of the branches
				// Is falling
				falling = true;
				sugar.y += 11;
				
				sugarToJump();
			}
			else
			{
				jumpCount = 0;
				falling = false;
				jumpToSugar();
			}
		}
		
		public function arrayBranches():void
		{
			// Add all the branches to the branches array
				// 1
			var B1:b1 = new b1();
			B1.y = 320;
			branches.push(B1);
				// 2
			var B2:b2 = new b2();
			B2.y = 315;
			branches.push(B2);
				// 3
			var B3:b3 = new b3();
			B3.y = 150;
			branches.push(B3);
				// 4
			var B4:b4 = new b4();
			B4.y = 150;
			branches.push(B4);
				// 5
			var B5:b5 = new b5();
			B5.y = 150;
			branches.push(B5);
				// 6
			var B6:b6 = new b6();
			B6.y = 150;
			branches.push(B6);
				// 7
			var B7:b7 = new b7();
			B7.y = 150;
			branches.push(B7);
		}
		
		// Method to determine the need for another branch to be put in the screenBranch array
		public function needBranches():void
		{
			// Loop to see if the branches are yet on the negative of their width
			for(var i:int = 0; i < screenBranches.length; i++)
			{
				// Is the width of the branch equal to the location off screen
				if(screenBranches[i].x < screenBranches[i].width * -1)
				{
					// Take down the location of last branch
					var leng:int = screenBranches.length;
					var loc:Number = screenBranches[leng - 1].x + screenBranches[leng - 1].width + space();
					
					// Remove that branch
					branches.push(screenBranches[i]);
					screenBranches.splice(i, 1);
					
					// Make a new branch
					var j:int = ranBranch();
					// Make sure the branch number is not larger than the array
					branches[j].x = loc;
					screenBranches.push(branches[j]);
					this.addChild(branches[j]);
					branches.splice(j, 1);
				}
			}
		}
		
		public function space():int
		{
			// Determines the gap between the branch spawns
			return Math.round(Math.random() * 200 + 100);
		}
		
		public function gameLost():void
		{
			if(sugar.y > 459)
			{
				autoLose();
			}
		}
		
		public function endELPause():void
		{
			// Remove event listeners of pause
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
		}
		
		public function autoLose():void
		{
			// End event listeners
				// Every frame
			this.removeEventListener(Event.ENTER_FRAME, everyFrame);
				// Keyboard
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyD);
			
			// He has fallen and thus lost the game
			MovieClip(root).clearGame(4, score);
		}
	}
	
}
