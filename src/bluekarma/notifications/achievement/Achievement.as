package notifications.achievement
{
    import assets.NotificationsAssets;

    import bluekarma.assets.sound.SoundAssets;

    import com.greensock.easing.Quart;
    import com.greensock.TweenLite;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import notifications.abstract.AbstractNotification;

    import starling.display.Image;
    import starling.events.Event;
    import starling.text.TextField;

    import states.GameState;

    /**
     *
     * @author Shaun Stone
     */
    public class Achievement extends AbstractNotification
    {
        protected var _scoreTextField:TextField;
        protected var _messageTextField:TextField;
        protected var _delayTime:Timer;

        public function Achievement(points:Number, message:String, duration:Number = 3.5)
        {
            super(points, message, duration);
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function showNotification():void
        {
            //SoundAssets.notificationSuccessHigh.play();
            TweenLite.to(this, _duration, {y: 5, ease: Quart.easeOut, onComplete: setDelayToShow});
        }

        protected function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            createNotification();
        }

        protected function createNotification():void
        {
            //first create background
            _bg = new Image(NotificationsAssets.getTexture("AchievementBg"));
            addChild(_bg);
            //then create score
            _scoreTextField = new TextField(60, 40, String(_points), "Arial", 24, 0xffffff);
            _scoreTextField.x = 5;
            _scoreTextField.y = 14;
            addChild(_scoreTextField);
            //then add text with message
            _messageTextField = new TextField(100, 30, _message, "Arial", 10, 0xffffff);
            _messageTextField.x = 75;
            _messageTextField.y = 20;
            addChild(_messageTextField);
            //hide
            this.x = Game.STAGE_WIDTH - this.width;
            this.y = -this.height;
            showNotification();
        }

        private function setDelayToShow():void
        {
            _delayTime = new Timer(_duration, 1);
            _delayTime.addEventListener(TimerEvent.TIMER_COMPLETE, removeNotification);
            _delayTime.start();
        }

        private function removeNotification(e:TimerEvent):void
        {
            _delayTime.removeEventListener(TimerEvent.TIMER_COMPLETE, removeNotification);
            TweenLite.to(this, 3, {y: -this.height, ease: Quart.easeIn, onComplete: removeSelf});
        }

        /**
         * Once shown it removes itself and adds to the main score
         */
        private function removeSelf():void
        {
            GameState.addScore(_points);
            this.removeFromParent(true);
        }
    }
}