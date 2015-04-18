package events
{
    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     */
    public class InteractionEvent extends Event
    {
        public static const INTERACT:String = "INTERACT";
        public var params:Object;

        public function InteractionEvent(type:String, _params:Object, bubbles:Boolean = false)
        {
            trace("the params passed to interaction event is: ");
            for (var id:String in _params) {
                var value:Object = _params[id];
                trace(id + " = " + value);
            }
            super(type, _params, bubbles);
            this.params = _params;
        }
    }
}