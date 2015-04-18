package states
{
    /**
     * ...
     * @author Shaun Stone
     */
    public class DecisionWheelState
    {

        /*
         *
         * Constants
         *
         */
        public static const NONE:String = "NONE";
        public static const EXAMINE:String = "EXAMINE";
        public static const CHAT:String = "CHAT";
        public static const ACTION:String = "ACTION";
        /*
         *
         * Variables
         *
         */
        public static var currentFocusedObject:String = NONE;
        public static var currentAction:String = NONE;

        public static function resetAction():void
        {
            DecisionWheelState.currentFocusedObject = NONE;
            DecisionWheelState.currentAction = NONE;
            Level1State.PLAYER_WALK = true;
        }
    }
}