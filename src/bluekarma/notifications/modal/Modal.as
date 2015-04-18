package notifications.modal
{
    import assets.NotificationsAssets;

    import bluekarma.assets.sound.SoundAssets;

    import com.greensock.easing.Quart;
    import com.greensock.TweenLite;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import global.Global;

    import notifications.abstract.AbstractNotification;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    /**
     * ...
     * @author @shaun
     */
    public class Modal extends Sprite
    {
        public const DEFAULT_DURATION:uint = 1;
        public static const EXCLAMATION:uint = 1;
        public static const QUESTION_MARK:uint = 2;
        public static const HINT:uint = 1;
        public static const WARNING:uint = 2;
        private var mark:uint;
        private var message:String;
        private var duration:Number;
        private var type:uint;
        private var bg:Image;
        private var markIndicator:TextField;
        private var messageTextField:TextField;
        private var delayTime:Timer;

        /**
         * @param message
         * @param mark
         * @param type
         * @param duration
         */
        public function Modal(message:String, mark:uint = EXCLAMATION, type:uint = HINT, duration:Number = DEFAULT_DURATION)
        {
            this.type = type;
            this.mark = mark;
            this.duration = duration;
            this.message = message;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function showNotification():void
        {
            var yToBe:Number = 655;
            //SoundAssets.notificationSuccessHigh.play();
            TweenLite.to(this, duration, {alpha: 1, y: yToBe, ease: Quart.easeOut});
            setDelayToShow();
        }

        /**
         *
         * @param e
         */
        protected function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            createNotification();
        }

        protected function createNotification():void
        {
            //first create background
            bg = new Image(NotificationsAssets.getTexture("ModalBg"));
            addChild(bg);
            //then create MARK INDICATOR
            var m:String = '?';
            if (mark === EXCLAMATION) {
                m = '!';
            }
            markIndicator = new TextField(58, 55, m, "Arial", 48, 0xffffff);
            markIndicator.x = 21;
            markIndicator.y = 15;
            markIndicator.border = false;
            addChild(markIndicator);
            //then add text with message
            messageTextField = new TextField(800, 55, message, Global.DEFAULT_FONT, 24, 0xffffff);
            messageTextField.x = 80;
            messageTextField.y = 15;
            messageTextField.border = false;
            addChild(messageTextField);
            this.alpha = 0;
            //hide
            this.x = 28;
            this.y = Game.STAGE_HEIGHT;
            showNotification();
        }

        private function setDelayToShow():void
        {
            delayTime = new Timer(5000, 1);
            delayTime.addEventListener(TimerEvent.TIMER_COMPLETE, removeNotification);
            delayTime.start();
        }

        /**
         *
         * @param e
         */
        private function removeNotification(e:TimerEvent):void
        {
            delayTime.removeEventListener(TimerEvent.TIMER_COMPLETE, removeNotification);
            TweenLite.to(this, duration, {alpha: 0, y: Game.STAGE_HEIGHT, ease: Quart.easeOut, onComplete: removeSelf});
        }

        /**
         * Once shown it removes itself
         */
        private function removeSelf():void
        {
            this.removeFromParent(true);
        }
    }
}