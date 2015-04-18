package score
{
	import apis.ThirdPartyAPI;
    /**
     * @author @shaun
     */
    public class Act2Score extends BaseActScore
    {
        /**
         * SENTENCES
         */
        public const COLLECT_ENFORCEMENT_GEAR_SENTENCE:String = 'Albert’s Cuffs';
        /**
         * SCORES
         */
        //Riley picks up his Elite Agent suit from drawer
        public const COLLECT_ENFORCEMENT_GEAR:uint = 250;

        public function Act2Score(api:ThirdPartyAPI)
        {
			currentAct = "Act 2";
            super(api);
            bonusScore = new Act2BonusScore();
        }

        public function getBonusAct():Act2BonusScore
        {
            return bonusScore;
        }
    }
}