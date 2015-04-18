package components.gestures.hold
{
    import com.greensock.TweenLite;

    /**
     * Used when a user touches a certain element on screen
     * @author @shaun
     */
    public class Select extends AbstractHold
    {
        public const SHOWING:uint = 1;
        public const HIDDEN:uint = 0;
        static public const DEFAULT_TIME:uint = 2;

        public function Select(duration:Number = DEFAULT_TIME)
        {
            this.touchable = false
            super(duration);
            draw();
            this.alpha = HIDDEN;
        }

        override protected function draw():void
        {
            super.draw();
        }

        public function show():void
        {
            this.alpha = SHOWING;
            remove();
        }

        private function remove():void
        {
            TweenLite.to(this, 1, {alpha: 0, onComplete: disposeOf});
        }

        private function disposeOf():void
        {
            this.alpha = HIDDEN;
        }
    }
}