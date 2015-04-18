package bluekarma.helpers.transitions
{
    import assets.GameAssets;

    import com.greensock.easing.Quad;
    import com.greensock.TweenMax;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import com.greensock.TweenLite;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Fader extends Sprite
    {
        private var _darkOverlay:Image;
        private var _seeable:Boolean;

        /**
         * Shows fader by default
         *
         * @param    visible
         */
        public function Fader(seeable:Boolean = true)
        {
            this._seeable = seeable;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         * Fade In the Fader from clear to dark
         *
         * @param    duration
         * @param    waitingDelay
         */
        public function fadeIn(duration:uint, waitingDelay:uint = 0):void
        {
            this.touchable = true;
            TweenLite.to(_darkOverlay, duration, {alpha: 1, ease: Quad.easeIn, delay: waitingDelay});
        }

        /**
         * Fade In the Fader from dark to clear
         *
         * @param    duration
         * @param    waitingDelay
         * @param    disposeOf
         */
        public function fadeOut(duration:uint, waitingDelay:uint = 0, disposeOf:Boolean = false):void
        {
            this.touchable = false;
            TweenMax.to(_darkOverlay, duration, {
                alpha: 0,
                ease: Quad.easeOut,
                delay: waitingDelay,
                onComplete: removeFader(disposeOf)
            });
        }

        /**
         * Hide the Fader
         *
         */
        public function hide():void
        {
            this.touchable = false;
            this.alpha = 0;
        }

        /**
         * Show the Fader
         *
         */
        public function show():void
        {
            this.touchable = true;
            this.alpha = 1;
        }

        /**
         * On added to stage draw
         *
         * @param e
         */
        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            this.touchable = false;
            determineVisiblity();
            drawOverlay();
        }

        private function determineVisiblity():void
        {
            if (!_seeable) {
                hide();
            }
        }

        /**
         * draw the Fader Overlay
         */
        private function drawOverlay():void
        {
            _darkOverlay = new Image(GameAssets.getTexture("Fader"));
            addChild(_darkOverlay);
        }

        /**
         * This gets called if user decides to remove once faded
         *
         * @param    disposeOf
         */
        private function removeFader(disposeOf:Boolean):void
        {
            //dispatchEventWith("faderComplete", true);
            //this.removeFromParent(disposeOf);
        }
    }
}