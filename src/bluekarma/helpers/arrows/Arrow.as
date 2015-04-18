package helpers.arrows
{
    import assets.GameAssets;

    import com.greensock.easing.Quad;
    import com.greensock.TweenLite;

    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.utils.Timer;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * ...
     * @author @shaunstone
     */
    public class Arrow extends Sprite
    {
        public static const UP:String = "up";
        public static const DOWN:String = "down";
        public static const LEFT:String = "left";
        public static const RIGHT:String = "right";
        private var arrow:Image;
        private var animate:Boolean;
        private var rotate:String;
        private var timer:Timer;
        private var originalPosition:Point;

        /**
         *
         * @param    rotation = DOWN
         */
        public function Arrow(rotate:String = DOWN, animate:Boolean = true)
        {
            this.animate = animate;
            this.rotate = rotate;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         *
         * @param    e
         */
        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            draw();
            animateArrow();
        }

        private function draw():void
        {
            arrow = new Image(GameAssets.getTexture("ArrowHint"));
            arrow.pivotX = (arrow.width / 2)
            arrow.pivotY = (arrow.height / 2)
            addChild(arrow);
            trace(this.x, this.y);
            this.originalPosition = new Point(Number(x), Number(y));
        }

        private function animateArrow(e:Event = null):void
        {
            trace("animate arrow");
            timer = new Timer(4000, 1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
            timer.start();
        }

        private function timerComplete(e:TimerEvent):void
        {
            trace("timer complete");
            timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
            var position:Number = 0;
            var chosen:Boolean = false;
            trace("this x is: ", this.x);
            trace("this height is: ", arrow.height);
            trace("calc ", originalPosition.x -= arrow.height);
            trace("rotation is: ", rotate);
            switch (rotate) {
                case UP :
                    position = Number(this.y += arrow.height);
                    chosen = true;
                    break;
                case DOWN :
                    position = Number(this.y -= arrow.height);
                    chosen = true;
                    break;
            }
            trace("moving positon to ", position);
            if (chosen) {
                trace("chosen up or down");
                trace(position);
                TweenLite.to(this, 4, {y: 200, ease: Quad.easeInOut, onComplete: returnToPosition()});
                return;
            }
            switch (rotate) {
                case LEFT :
                    position = Number(this.x -= arrow.width);
                    break;
                case RIGHT :
                    position = Number(this.x += arrow.width);
                    break;
            }
            TweenLite.to(this, 4, {x: position, ease: Quad.easeInOut, onComplete: returnToPosition()});
        }

        private function returnToPosition():void
        {
            trace("return to position");
            TweenLite.to(this, 1, {
                x: this.originalPosition.x,
                y: this.originalPosition.y,
                ease: Quad.easeInOut,
                onComplete: animateArrow()
            });
        }
    }
}