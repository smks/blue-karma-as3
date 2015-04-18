package components.gestures.swipes
{
    import assets.GestureAssets;

    import com.greensock.easing.Circ;
    import com.greensock.TweenLite;

    import flash.geom.Point;

    import global.Global;

    import starling.display.Image;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.TextureAtlas;

    /**
     * Allows for a slider to be touched to go left to right
     * or vice versa, dispatched a confirmation
     *
     *
     * @author @shaun
     */
    public class Swipe extends AbstractSwipe
    {
        private const LEFT_STOP:uint = 4;
        private const RIGHT_STOP:uint = 106;
        private var bg:Image;
        private var slider:Image;
        private var border:Image;
        private var touching:Boolean = false;

        public function Swipe(direction:String = Global.LEFT)
        {
            super(direction);
            draw();
            position();
            TweenLite.to(this, 1.2, {alpha: 1, ease: Circ.easeOut, onComplete: initialize});
        }

        /**
         * Draw the assets
         *
         */
        override protected function draw():void
        {
            var atlas:TextureAtlas = GestureAssets.getAtlas();
            bg = new Image(atlas.getTexture("swipe-bg"));
            addChild(bg);
            slider = new Image(atlas.getTexture("slider"));
            slider.y = 4;
            addChild(slider);
            border = new Image(atlas.getTexture("swipe-border"));
            addChild(border);
            this.alpha = 0;
        }

        override protected function onTouchHandler(event:TouchEvent):void
        {
            var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.MOVED);
            if (touches.length == 1) {
                // one finger touching -> move
                var delta:Point = touches[0].getMovement(parent);
                slider.x += delta.x;
                if (direction === Global.LEFT) {
                    if (slider.x < LEFT_STOP) {
                        slider.x = LEFT_STOP;
                        complete();
                    }
                } else if (direction === Global.RIGHT) {
                    if (slider.x > RIGHT_STOP) {
                        slider.x = RIGHT_STOP
                        complete();
                    }
                }
                if (slider.x < LEFT_STOP) {
                    slider.x = LEFT_STOP;
                }
                if (slider.x > RIGHT_STOP) {
                    slider.x = RIGHT_STOP;
                }
            }
        }

        /**
         * Position slider to the left or right
         * based on direction chosen
         *
         */
        protected function position():void
        {
            switch (direction) {
                case Global.LEFT :
                    slider.x = RIGHT_STOP;
                    break;
                case Global.RIGHT:
                    slider.x = LEFT_STOP;
                    break;
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
            // dispatch event to inform that gesture has completed
            dispatchEventWith("GestureEvent", true, {type: "swipe", response: "success"});
            TweenLite.to(this, 1.2, {alpha: 0, ease: Circ.easeOut, onComplete: remove});
        }

        private function remove():void
        {
            removeFromParent(true);
        }
    }
}