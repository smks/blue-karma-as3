package score
{
	import apis.ThirdPartyAPI;
    /**
     * ...
     * @author @shaun
     */
    public class Act5Score extends BaseActScore
    {
        /**
         * SENTENCES
         */
        public const ARREST_DAWSON_SENTENCE:String = 'Arrest Alex Dawson';
        /**
         * SCORES
         */
        //Apply handcuffs on Dawson
        public const ARREST_DAWSON:uint = 5000;

        public function Act5Score(api:ThirdPartyAPI)
        {
            currentAct = "Act 5";
            super(api);
            bonusScore = new Act5BonusScore();
        }

        public function getBonusAct():Act5BonusScore
        {
            return bonusScore;
        }
    }
}