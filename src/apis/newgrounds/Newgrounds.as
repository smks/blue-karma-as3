package apis.newgrounds
{
	import adobe.utils.CustomActions;
	import apis.interfaces.ThirdParty;
    import com.newgrounds.*;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
    import flash.display.Sprite;
    import flash.events.Event;

    /**
     * @author Shaun Stone
     */
    public class Newgrounds extends Sprite implements ThirdParty
    {
        public static const API_KEY:String = 'SECRET';
        public static const ENC_KEY:String = 'SECRET';
        public static const SCOREBOARD:String = "Elite Agent Rankings";
        public static const SCOREBOARD_TIME:String = "Elite Agent Time Trial";

        private var _name:String = 'Newgrounds';
        private var connected:Boolean = false;
		private var stageRoot:Stage;
		private var stageRequired:Boolean = true;
        ;
        public function Newgrounds()
        {
            trace("instantiated " + _name + " API");
        }

        /**
         * @return bool
         */
        public function connect():void
        {
			if (BlueKarma.ENVIRONMENT == BlueKarma.TESTING) {
				API.debugMode = API.DEBUG_MODE_LOGGED_IN;
			} else {
				API.debugMode = API.RELEASE_MODE;
			}
			
			// make connection
            API.connect(stageRoot, Newgrounds.API_KEY, Newgrounds.ENC_KEY);
			this.addEventListener(APIEvent.MEDAL_UNLOCKED, showMedal);
        }
		
		public function disconnect():void
		{
			API.disconnect();
			this.removeEventListener(APIEvent.MEDAL_UNLOCKED, showMedal);
		}
        /**

         * Has the score been posted successfully
		 * @example this.api.postScore(1200);
         * @return bool
         */
        public function postScore(score:int):void
        {
			checkConnection();
			API.postScore(Newgrounds.SCOREBOARD, score, BlueKarma.NAME);
        }

        /**
         * Post the final time it took for the level to complete
         * @example this.api.postTime(9000);
         * @param milliseconds
         * @return bool
         */
        public function postTime(milliseconds:int):void
        {
			checkConnection();
			API.postScore(Newgrounds.SCOREBOARD_TIME, milliseconds, BlueKarma.NAME + " Time");
        }
		
		/**
		 * @example this.api.unlockMedal(Medals.BONUS_MANS_BEST_FRIEND);
		 * @param name
		 */
		public function unlockMedal(name:String):void
		{
			checkConnection();
			API.unlockMedal(name);
		}
		
		private function checkConnection():void 
		{
			if (API.connected === false) {
				throw new Error("Should not use API when not connected");
			}
		}
		
		/**
		 * @param stage
		 */
		public function setStage(stage:Stage):void 
		{
			this.stageRoot = stage;
		}
		
		/**
		 * @return bool
		 */
		public function requiresStage():Boolean 
		{
			return stageRequired;
		}
		
		/**
		 * Newgrounds allows us to show medal
		 * @param e
		 */
		private function showMedal(e:APIEvent):void 
		{
			if (e.success) {
				 var medal:Medal = Medal(e.data);
				trace("Medal was unlocked: " + medal.name);
			} else {
				trace("Medal unlock failed: " + e.error);
			}
		}
    }
}