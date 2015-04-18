package states
{
    import starling.display.Sprite;

    import flash.globalization.DateTimeFormatter;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Level1State
    {
        public static var CLOCK:Date = new Date(2042, 09, 18, 19, 32, 0);
        /*
         *
         * This is used to count how many items the user currently has
         *
         */
        public static var ITEMS_STORED:uint = 0;
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
         * This is current rank of player
         *
         */
        public static var PLAYER_RANK:String = "Amateur";
        /*
         *
         * This is current Leaderbord rank of player
         *
         */
        public static var PLAYER_LEADER_RANK:Number = 320;
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
         * Methods
         *
         */
        public static function changeBackground():void
        {
            return;
        }

        public static function setClockTime(timeAndDate:String):void
        {
            Level1State.CLOCK = new Date(timeAndDate);
        }

        public static function getClockTime():String
        {
            var timeFormat:DateTimeFormatter = new DateTimeFormatter("en-UK");
            timeFormat.setDateTimePattern("HH:mm:ss");
            return String(timeFormat.format(Level1State.CLOCK));
        }

        public static function getClockDate():String
        {
            var timeFormat:DateTimeFormatter = new DateTimeFormatter("en-UK");
            timeFormat.setDateTimePattern("dd/MM/yyyy");
            return String(timeFormat.format(Level1State.CLOCK));
        }
    }
}