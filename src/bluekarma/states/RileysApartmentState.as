package states
{
    /**
     * ...
     * @author Shaun Stone
     */
    public class RileysApartmentState
    {
        public static var CLOCK:Date = new Date(2013, 0, 0, 20, 15, 0);
        /*
         *
         * This is used to keep track of how far the user has progressed in the game
         *
         */
        public static var PROGRESS_NUMBER:uint = 0;
        /*
         *
         * This is used to keep track of how far the user has progressed in the game
         *
         */
        public static var CURRENT_STATE:uint = 1;
        /*
         *
         * This is used to know what background to show
         *
         */
        public static var BACKGROUND_NUMBER:uint = 1;
        /*
         *
         * This is used to count how many items the user currently has
         *
         */
        public static var ITEMS_STORED:uint = 0;
        /*
         *
         * This is used to count how many items the user currently has
         *
         */
        public static var CURRENT_ITEM:uint = 0;
        /*
         *
         * This is used to count how many items have been trashed
         *
         */
        public static var ITEMS_TRASHED:uint = 0;
        /*
         *
         * This is used to count how many items have been examined
         *
         */
        public static var ITEMS_EXAMINED:uint = 0;
        /*
         *
         * This is used to count how many time the user has spoke to people
         *
         */
        public static var PEOPLE_SPOKEN_TO:uint = 0;
        /*
         *
         * This is used to count how many good questions asked
         *
         */
        public static var DECISIONS_CORRECT:uint = 0;
        /*
         *
         * This is used to count how many bad decisions made
         *
         */
        public static var DECISIONS_WRONG:uint = 0;
        /*
         *
         * This is the artificial bit cash in the game
         *
         */
        public static var PLAYER_WALK:Boolean;
        /*
         * Player Change
         */
        private static var BIT_CASH:Number = 0;
        /*
         *
         * Methods
         *
         */
        public static function changeBackground():void
        {
            return;
        }

        public static function getClockTime():String
        {
            var timeFormat:DateTimeFormatter = new DateTimeFormatter("en-UK");
            timeFormat.setDateTimePattern("HH:mm:ss");
            return String(timeFormat.format(Level1State.CLOCK));
        }
    }
}