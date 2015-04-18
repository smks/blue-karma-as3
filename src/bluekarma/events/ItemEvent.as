package events
{
    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     */
    public class ItemEvent extends Event
    {
        public static const PICKUP:String = "PICKUP";
        public static const ADD:String = "ADD";
        public static const DELETE:String = "DELETE";
        public static const COMBINE:String = "COMBINE";
        public var params:Object;

        public function ItemEvent(type:String, _params:Object, bubbles:Boolean = true)
        {
            trace("the params passed to item event is: ");
            for (var id:String in _params) {
                var value:Object = _params[id];
                trace(id + " = " + value);
            }
            super(type, _params, bubbles);
            this.params = _params;
        }
    }
}