package bluekarma.components.gestures.hold
{
    import assets.GestureAssets;

    import com.greensock.easing.Circ;
    import com.greensock.TweenLite;

    import components.gestures.hold.AbstractHold;

    import flash.geom.Point;

    import global.Global;

    import starling.display.Image;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.TextureAtlas;

    /**
     * Allows for user to tap down to fill the circle
     *
     *
     * @author @shaun
     */
    public class Hold extends AbstractHold
    {
        /**
         *
         * @param    duration
         * @param    id
         */
        public function Hold(duration:Number = 3, id:String = 'default')
        {
            super(duration);
            this.id = id;
            draw();
            TweenLite.to(this, 1.2, {alpha: 1, ease: Circ.easeInOut, onComplete: initialize});
        }

        protected function onTouchHandler(event:TouchEvent):void
        {
            var touch:Touch = event.getTouch(this);
            if (touch === null) {
                return;
            }
            if (touch.phase == TouchPhase.BEGAN) {
                //do your stuff
                addEventListener(Event.ENTER_FRAME, onHold);
            }
            if (touch.phase == TouchPhase.ENDED) //on finger up
            {
                //stop doing stuff
                removeEventListener(Event.ENTER_FRAME, onHold);
            }
        }

        private function initialize():void
        {
            addEventListener(TouchEvent.TOUCH, onTouchHandler);
        }

        private function onHold(e:Event):void
        {

            // 3 seems to work for some reason :/
            var growth:Number = 3 / duration;
            // increase size of expander
            expander.scaleX += growth / 100;
            expander.scaleY += growth / 100;
            // if scale 1 then complete
            if (expander.scaleX >= 1) {
                expander.scaleX = 1;
                expander.scaleY = 1;
                removeEventListener(Event.ENTER_FRAME, onHold);
                complete();
            }
        }

        /**
         * Remove touch listener and dispatched event
         *
         */
        private function complete():void
        {
            // remove listener
            removeEventListener(TouchEvent.TOUCH, onTouchHandler);
            trace("GestureEvent dispatched");
            // dispatch event to inform that gesture has completed
            dispatchEventWith("GestureEvent", true, {id: id, type: "hold", response: "success"});
            TweenLite.to(this, 1, {alpha: 0, scaleX: 1.6, scaleY: 1.6, ease: Circ.easeInOut, onComplete: remove});
        }

        private function remove():void
        {
            removeFromParent(true);
        }
    }
}