package decisions
{
    import starling.display.Sprite;

    import helpers.MessageBox;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractDecision extends Sprite
    {
        public static const EXAMINE:String = "examine";
        public static const ACTION:String = "action";
        public static const CHAT:String = "chat";
        protected var _objectType:String;
        protected var _objectId:String;
        protected var _state:uint;
        protected var _messageBox:MessageBox;

        public function AbstractDecision(type:String, id:String, state:uint)
        {
            this._objectType = type;
            this._objectId = id;
            this._state = state;
            processDecision();
        }

        public function getObjectType():String
        {
            return _objectType;
        }

        public function getObjectId():String
        {
            return _objectId;
        }

        public function getState():uint
        {
            return _state;
        }

        protected function processDecision():void
        {
        }
    }
}