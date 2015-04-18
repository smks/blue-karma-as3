package score
{
	import apis.ThirdPartyAPI;
    /**
     * ...
     * @author @shaun
     */
    public class Act4Score extends BaseActScore
    {
		/**
         * SENTENCES
         */
        public const TRADESMEN_TOOLBOX_SENTENCE:String = 'Albert’s Cuffs';
        //
        public const WE_HAVE_NOISE_SENTENCE:String = 'Fan Noise distraction';
        public const BREAK_IN_SENTENCE:String = 'Break into Compound';
        /**
         * SCORES
         */
        //Riley Leaves the toolbox shut after use
        public const TRADESMEN_TOOLBOX:uint = 400;
		//Turn on the Fan
		public const WE_HAVE_NOISE:uint = 800;
		//Apply crowbar on Window
        public const BREAK_IN:uint = 2000;

        public function Act4Score(api:ThirdPartyAPI)
        {
            currentAct = "Act 4";
            super(api);
            bonusScore = new Act4BonusScore();
        }

        public function getBonusAct():Act4BonusScore
        {
            return bonusScore;
        }
    }
}