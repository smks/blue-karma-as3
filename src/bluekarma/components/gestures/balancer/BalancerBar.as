package components.gestures.balancer
{
    import adobe.utils.CustomActions;

    import assets.GestureAssets;

    import bluekarma.interactive.compound.RileyCable;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import global.Global;

    import helpers.arrows.Arrow;

    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.textures.TextureAtlas;

    /**
     * @author Shaun Stone
     */
    public class BalancerBar extends Sprite
    {
        private const GAP_SPACE:uint = 10;
        static private const SPEED:Number = 10;
        static private const MAX_SCORE:Number = 2000;
        private var arrowLeft:ArrowPush;
        private var arrowRight:ArrowPush;
        private var bar:Image;
        private var completeBar:CompleteBar;
        private var fullWidth:uint;
        private var barDial:BarDial;
        private var arrows:Array = new Array();
        private var resolution:String = 'failed';
        private var timer:Timer;
        private var timerScore:Number = MAX_SCORE;
        private var objects:Object;

        public function BalancerBar(obj:Object)
        {
            this.objects = obj;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function startTimingMiniGame():void
        {
            timer = new Timer(100);
            timer.addEventListener(TimerEvent.TIMER, addToTime);
            timer.start();
        }

        public function finishedMiniGame():void
        {
            if (timer === null) {
                throw new Error("You forgot to start the timer! DOH!");
            }
            timer.stop();
            if (BlueKarma.ENVIRONMENT === BlueKarma.TESTING) {
                var tf:TextField = new TextField(200, 100, String(timerScore), Global.DEFAULT_FONT, 14);
                tf.x = 300;
                tf.y = 300;
                parent.addChild(tf);
            }
        }

        public function getScore():Number
        {
            return timerScore;
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            arrowLeft = new ArrowPush(Global.LEFT, GestureAssets.getAtlas().getTexture("arrow"));
            arrowLeft.flipLeft();
            addChild(arrowLeft);
            bar = new Image(GestureAssets.getAtlas().getTexture("bar-bg"));
            bar.x = (arrowLeft.width + GAP_SPACE);
            addChild(bar);
            barDial = new BarDial(bar.x, (bar.width + arrowLeft.width), GAP_SPACE, bar.height, Global.BLUE_KARMA_BLACK);
            barDial.x = bar.x;
            addChild(barDial);
            arrowRight = new ArrowPush(Global.RIGHT, GestureAssets.getAtlas().getTexture("arrow"));
            arrowRight.x = (arrowLeft.width + bar.width + (GAP_SPACE * 2));
            addChild(arrowRight);
            arrows = [
                arrowLeft,
                arrowRight
            ];
            completeBar = new CompleteBar(0, calculateWidths(), 5, 20, Global.BLUE_KARMA_BLUE);
            completeBar.alpha = 0.5;
            completeBar.y = (arrowRight.height + GAP_SPACE);
            addChild(completeBar);
            addEventListener(TouchEvent.TOUCH, onTouch);
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function addToTime(e:TimerEvent):void
        {
            if (timerScore <= 0) {
                timerScore = 0;
                // timer run out
                failed();
                return;
            }
            // remove from score
            timerScore -= 1;
        }

        private function onEnterFrame(e:Event):void
        {
            calculate(e);
        }

        private function onTouch(event:TouchEvent):void
        {
            var touchBegan:Touch = event.getTouch(this, TouchPhase.BEGAN);
            var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
            var touchHover:Touch = event.getTouch(this, TouchPhase.HOVER);
            if (touchBegan) {
                if (event.target is ArrowPush) {
                    var arrow:ArrowPush = event.target as ArrowPush;
                    arrow.setHolding(true);
                }
            }
            // Set all arrows to not holding down
            if (touchEnded) {
                for (var i:uint = 0; i < arrows.length; i++) {
                    arrows[i].setHolding(false);
                }
            }
        }

        private function calculate(e:Event):void
        {
            if (arrowLeft.isHoldingDown()) {
                getRileySubject().setFrameRate(getRileySubject().getFps() - 1);
                barDial.decrease(SPEED);
            }
            if (arrowRight.isHoldingDown()) {
                getRileySubject().setFrameRate(getRileySubject().getFps() + 1);
                barDial.increase(SPEED);
            }
            if (barDial.isGreaterThanMidPoint()) {
                barDial.increase(4);
            }
            if (barDial.isLessThanMidPoint()) {
                barDial.decrease(4);
            }
            if (barDial.isLessThanBeginMidEndPoint()) {
                barDial.decrease(2);
            }
            if (barDial.isGreaterThanMidEndPoint()) {
                barDial.increase(2);
            }
            completeBar.increase(barDial.getAcceleration());
            if (barDial.getAcceleration() === 0) {
                getRileySubject().setFrameRate(1);
            }
            if (completeBar.isBarComplete()) {
                complete();
            }
            if (barDial.inRed()) {
                failed();
            }
        }

        private function failed():void
        {
            finishedMiniGame();
            removeListeners();
            dispatchEventWith("balancerResolution", true, {resolution: this.resolution});
        }

        private function complete():void
        {
            finishedMiniGame();
            removeListeners();
            setResolution('success');
            dispatchEventWith("balancerResolution", true, {resolution: this.resolution});
        }

        private function setResolution(string:String):void
        {
            this.resolution = string;
        }

        private function calculateWidths():Number
        {
            return fullWidth = arrowLeft.width + bar.width + (GAP_SPACE * 2) + arrowRight.width;
        }

        private function removeListeners():void
        {
            var rc:RileyCable = getRileySubject();
            rc.stop();
            removeEventListener(TouchEvent.TOUCH, onTouch);
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function getRileySubject():RileyCable
        {
            if (objects.rileyCable === null) {
                throw new Error("Riley cable not set");
            }
            return objects.rileyCable;
        }
    }
}