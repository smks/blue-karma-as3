package states
{
    import starling.display.Sprite;

    /**
     * ...
     * @author Shaun Stone
     */
    public class GameState
    {
        /*
         *
         * This class stores all the global vars needed throughout the game
         *
         */
        public static const DIRECTION_RIGHT:String = "RIGHT";
        public static const DIRECTION_LEFT:String = "LEFT";
        public static const DIRECTION_UP:String = "UP";
        public static const DIRECTION_DOWN:String = "DOWN";
        /*
         * Main States
         */
        //the user score is tracked throughout
        public static const STAGE_WIDTH:uint = 1024;
        // set to true if the game is over
        public static const STAGE_HEIGHT:uint = 768;
        //Current Level
        public static const NOTIFICATION_NONE_STRING:String = "There are no notifications";
        //Current Level Label
        public static var GAME_SCORE:Number = 0;
        //current Player
        public static var GAME_OVER:Boolean;
        //used to determine if game is waiting on a decision (Decision Wheel)
        public static var CURRENT_LEVEL:int = 1;
        //current Time
        public static var CURRENT_LEVEL_LABEL:String = "Act 1 - The Slums";
        //width & height of stage
        public static var CURRENT_PLAYER:String = "Riley";
        public static var AWAITING_DECISION:Boolean = false;
        /*
         * Mobile States
         */
        //notifications
        public static var TIME:Date;
        public static var NOTIFICATIONS:Array = [];
        public static var NEW_NOTIFICATIONS:Boolean = false;
        public static var NOTIFICATIONS_NEW_STRING:String = "Call Uncle";
        /*
         * Level States
         */
        public static function resetScore():void
        {
            GAME_SCORE = 0;
        }

        /*
         * Score methods
         */
        public static function addScore(value:Number):void
        {
            GAME_SCORE += value;
        }

        public static function removeScore(value:Number):void
        {
            GAME_SCORE -= value;
        }

        public static function setGameOver():void
        {
            trace("game is over");
        }

        /*
         * Game Change
         */
        public static function getNotifications():String
        {
            var notifications:String;
            NOTIFICATIONS.push("Call Uncle");
            if (GameState.NOTIFICATIONS.length > 0) {

                //set up boolean true
                NEW_NOTIFICATIONS = true;
                //assign notifications to strings
                notifications = NOTIFICATIONS_NEW_STRING;
                return notifications;
            }
            return GameState.NOTIFICATION_NONE_STRING;
        }

        public function setSlumsStreetState():void
        {
            GAME_SCORE = 0;
            CURRENT_LEVEL = 1;
            GAME_OVER = false;
        }
    }
}