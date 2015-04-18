package components.gestures.swipes
{
    import starling.display.Sprite;
    import starling.events.TouchEvent;

    /**
     * ...
     * @author @shaun
     */
    public class AbstractSwipe extends Sprite
    {
        protected var direction:String;

        public function AbstractSwipe(direction:String)
        {
            this.direction = direction;
        }

        protected function initialize():void
        {
            addEventListener(TouchEvent.TOUCH, onTouchHandler);
        }

        protected function onTouchHandler(e:TouchEvent):void
        {
        }

        protected function draw():void
        {
        };
        protected function swipe():void
        {
        };
    }
}