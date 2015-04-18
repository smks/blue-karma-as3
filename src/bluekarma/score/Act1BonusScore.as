package score
{
    /**
     * ...
     * @author @shaun
     */
    public class Act1BonusScore
    {
        /**
         * SENTENCES
         */
        public const WATERED_PLANTS_SENTENCE:String = 'Healthy Plant';
        public const BEDROOM_MAINTAINER_SENTENCE:String = 'Bedroom Maintained';
        public const SAVED_WATER_BILLS_SENTENCE:String = 'Saved Water Bills';
        public const MANS_BEST_FRIEND_SENTENCE:String = 'Man’s Best Friend';
        public const CITY_ADMIRER_SENTENCE:String = 'City Admirer';
        public const APARTMENT_NOTIFICATIONS_SENTENCE:String = 'Notifications Cleared - ACT 1';
        /**
         * SCORES
         */
        //Riley adds water to the plant in his room
        public const WATERED_PLANTS:uint = 1000;
		//The bed is done, the draws are closed, the en-suite door
        // is shut and the washing basket lid is on.
        public const BEDROOM_MAINTAINER:uint = 1500;
		//The kitchen tap is off
        public const SAVED_WATER_BILLS:uint = 500;
		//Riley speaks to Crunch to see how he’s doing
        public const MANS_BEST_FRIEND:uint = 1200;
		//Examine the City view 3 times.
        public const CITY_ADMIRER:uint = 550;
		//Riley speaks to Crunch to see how he’s doing
        public const APARTMENT_NOTIFICATIONS:uint = 2000;
        /**
         * ACT
         */
        protected var currentAct:String = 'Act 1';

        public function Act1BonusScore()
        {
            super();
        }
    }
}