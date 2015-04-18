package bluekarma.score.menu 
{
	import assets.ScoreMenuAssets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author Shaun Stone
	 */
	public class Rank extends Sprite 
	{
		private const RANK_A:String = 'A';
		private const RANK_B:String = 'B';
		private const RANK_C:String = 'C';
		private const RANK_D:String = 'D';
		private const RANK_E:String = 'E';
		private const RANK_F:String = 'F';
		
		private var score:uint;
		private var chosenRank:String;
		private var image:Image;
		
		public function Rank(score:uint) 
		{
			this.score = score;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			chosenRank = this.calculateRankByScore(score);
			draw();
		}
		
		private function draw():void 
		{
			image = new Image(ScoreMenuAssets.getAtlas().getTexture(chosenRank));
			addChild(image);
		}
		
		/**
		 * Decide the rank of the player
		 * @param	score
		 * @return
		 */
		private function calculateRankByScore(score:uint):String 
		{
			if (score >= 30000) {
				return RANK_A;
			}
			
			if (score > 20000 && score <= 29999) {
				return RANK_B;
			}
			
			if (score > 15000 && score <= 20000) {
				return RANK_C;
			}
			
			if (score > 10000 && score <= 15000) {
				return RANK_D;
			}
			
			if (score > 5000 && score <= 10000) {
				return RANK_E;
			}
		
			return RANK_F;
		}
	}
}