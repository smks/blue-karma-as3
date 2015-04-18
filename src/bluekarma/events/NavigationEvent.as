package events
{
    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     */
    public class NavigationEvent extends Event
    {
        public static const CHANGE_SCREEN:String = "changeScreen";
        public var params:Object;

        public function NavigationEvent(type:String, params:Object, bubbles:Boolean = false)
        {
            super(type, bubbles);
        }
    }
}