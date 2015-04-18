package score
{
	import apis.ThirdPartyAPI;
    /**
     * ...
     * @author @shaun
     */
    public class Act3Score extends BaseActScore
    {
        /**
         * SENTENCES
         */
        public const FIND_COMPOUND_SENTENCE:String = 'Found Compound';
        public const ANOTHER_WAY_SENTENCE:String = 'Another way in';
        /**
         * SCORES
         */
        public const FIND_COMPOUND:uint = 500;
		public const ANOTHER_WAY:uint = 500;

        public function Act3Score(api:ThirdPartyAPI)
        {
			currentAct = "Act 3";
            super(api);
            bonusScore = new Act3BonusScore();
        }

        public function getBonusAct():Act3BonusScore
        {
            return bonusScore;
        }
    }
}