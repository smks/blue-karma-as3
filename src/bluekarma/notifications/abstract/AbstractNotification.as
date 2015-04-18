package notifications.abstract
{
    import assets.NotificationsAssets;

    import flash.events.Event;

    import starling.display.Sprite;
    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractNotification extends Sprite
    {
        protected var _bg:Image;
        protected var _points:Number;
        protected var _message:String;
        protected var _duration:Number;

        /**
         *
         */
        public function AbstractNotification(points:Number, message:String, duration:Number = 3.5):void
        {
            _points = points;
            _message = message;
            _duration = duration;
        }
    }
}