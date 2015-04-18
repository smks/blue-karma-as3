package helpers.transitions
{
    import com.greensock.easing.Quad;
    import com.greensock.TweenLite;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import global.Global;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    /**
     * @author Shaun Stone
     */
    public class ActIntroduction extends Sprite
    {
        private var levelLabel:String;
        private var actLabel:String;
        private var titleLabel:String;
        private var level:TextField;
        private var act:TextField;
        private var title:TextField;
        private var fadeInLength:uint;
        private var fadeOutLength:uint;
        private var duration:uint;

        public function ActIntroduction(_levelLabel:String, _actLabel:String = '', _titleLabel:String = '', _fadeIn:uint = 2, _fadeOut:uint = 2, _duration:uint = 4)
        {
            levelLabel = _levelLabel;
            actLabel = _actLabel;
            titleLabel = _titleLabel;
            fadeInLength = _fadeIn;
            fadeOutLength = _fadeOut;
            duration = _duration;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            draw();
        }

        private function draw():void
        {
            title = new TextField(400, 60, titleLabel.toUpperCase(), Global.DEFAULT_FONT, 32, Global.BLUE_KARMA_WHITE, true);
            //title.y = -30;
            title.alpha = 0;
            addChild(title);
            TweenLite.to(title, fadeInLength, {delay: 1.5, alpha: 1, ease: Quad.easeOut, onComplete: delayShowing});
            /**
             level = new TextField(400, 60, levelLabel.toUpperCase(), Global.DEFAULT_FONT, 32, 0x406782, true);
             level.y = -30;
             level.alpha = 0;
             addChild(level);
             TweenLite.to(level, fadeInLength, {delay: 1.5, alpha: 1, ease: Quad.easeOut, onComplete: delayShowing});
             if (actLabel !== '') {
                act = new TextField(400, 60, actLabel, Global.DEFAULT_FONT, 24, 0xffffff, true);
                act.alpha = 0;
                addChild(act);
                TweenLite.to(act, fadeInLength, {delay: 1.5, alpha: 1, ease: Quad.easeOut, onComplete: delayShowing});
            }
             if (titleLabel !== '') {
                title = new TextField(400, 60, titleLabel, Global.DEFAULT_FONT, 18, 0xffffff, false);
                title.y = 25;
                title.alpha = 0;
                addChild(title);
                TweenLite.to(title, fadeInLength, {delay: 1.5, alpha: 1, ease: Quad.easeOut, onComplete: delayShowing});
            }

             **/
        }

        private function delayShowing():void
        {
            var timer:Timer = new Timer(1000, duration);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, removeIntroduction);
            timer.start();
        }

        private function removeIntroduction(e:TimerEvent):void
        {
            TweenLite.to(this, fadeOutLength, {alpha: 0, ease: Quad.easeIn, onComplete: remove});
        }

        private function remove():void
        {
            this.removeFromParent(true);
        }
    }
}