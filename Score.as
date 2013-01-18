package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	
	public class Score extends MovieClip {
		
		public var score:Number;
		public var scoreBox:TextField;
		
		public function Score(finalScore:Number) {
			// constructor code
			score = finalScore;
			this.scoreBox.text = "Score: " + score;
		}
		
		// Set
		public function setScore(val:Number):void
		{
			score = val;
			this.scoreBox.text = "Score: " + score;
		}
	}
}
