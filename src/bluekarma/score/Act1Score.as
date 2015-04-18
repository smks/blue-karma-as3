package score
{
	import apis.ThirdPartyAPI;
    /**
     * ...
     * @author @shaun
     */
    public class Act1Score extends BaseActScore
    {
        /**
         * SENTENCES
         */
        public const FIND_SUIT_SENTENCE:String = 'Find Agent Suit';
        public const PYJAMA_WASH_SENTENCE:String = 'Pyjamas ready for wash';
        public const RESPONSIBLE_OWNER_SENTENCE:String = 'Prepared food for Crunch';
        /**
         * SCORES
         */
        //Riley picks up his Elite Agent suit from drawer
        public const FIND_SUIT:uint = 300;
		public const PYJAMA_WASH:uint = 300;
        //Put the pyjamas in the washing basket
        public const RESPONSIBLE_OWNER:uint = 500;
        //Prepare dog food for Crunch

        public function Act1Score(api:ThirdPartyAPI)
        {
			currentAct = "Act 1";
            super(api);
            bonusScore = new Act1BonusScore();
        }

        public function getBonusAct():Act1BonusScore
        {
            return bonusScore;
        }
    }
}