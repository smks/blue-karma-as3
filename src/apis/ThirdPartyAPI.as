package apis
{
	import apis.interfaces.ThirdParty;
	import apis.newgrounds.Newgrounds;
    import flash.display.Sprite;
	import flash.display.Stage;
    import flash.events.Event;

    /**
     * Facade for API transactions
     *
     * @author Shaun Stone
     */
    public class ThirdPartyAPI
    {
        private var api:ThirdParty;
		private var stage:Stage;

        public function ThirdPartyAPI(api:ThirdParty, stage:Stage)
        {
            this.api = api;
            this.stage = stage;
			
			if (this.api.requiresStage()) {
				this.api.setStage(stage);
			}
        }
		
		public function connect():void
		{
			this.api.connect();
		}
		
		public function disconnect():void
		{
			this.api.disconnect();
		}

        /**
		 * Post a score to the API we are using
         *
         * @param score
         * @return
         */
        public function postScore(score:int):void
        {
            this.api.postScore(score);
        }

        /**
         * Post a time in miliseconds to the API we are using
         *
         * @param score
         * @return
         */
        public function postTime(milliseconds:int):void
        {
            this.api.postTime(milliseconds);
        }

        /**
         * Unlock a Medal
         *
         * @param score
         * @return
         */
        public function unlockMedal(name:String):void
        {
            this.api.unlockMedal(name);
        }
    }
}