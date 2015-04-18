package score
{
    /**
     * ...
     * @author @shaun
     */
    public class Act3BonusScore
    {
		//Read all notifications
        /**
         * SENTENCES
         */
        public const STREET_SIGN_CHECK_SENTENCE:String = 'Albert’s Cuffs';
        public const HOUSE_CHECKER_SENTENCE:String = 'House Checker';
        public const FULL_VETTER_SENTENCE:String = 'Full Vetter';
        public const SLUMS_NOTIFICATIONS_CLEAR_SENTENCE:String = 'Notifications Cleared - ACT 3';
        public const WISE_MAN_SENTENCE:String = 'Avoided bodyguards attack';
        /**
         * SCORES
         */
        //Examine the street sign to make sure you’re on the right street.
        public const STREET_SIGN_CHECK:uint = 1500;
		// Examine the house
		public const HOUSE_CHECKER:uint = 600;
        //Examine the middle house along the slums street
        public const FULL_VETTER:uint = 2500;
        //Examine everyone along the street
        public const SLUMS_NOTIFICATIONS_CLEAR:uint = 2000;
		// Don't go into Compound through front door
        public const WISE_MAN:uint = 1200;
        /**
         * ACT
         */
        protected var currentAct:String = 'Act 3';

        public function Act3BonusScore()
        {
            super();
        }
    }
}