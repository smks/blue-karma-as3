package bluekarma.components.conditions
{
    import assets.components.ECGAssets;

    import bluekarma.assets.sound.SoundAssets;

    import flash.events.TimerEvent;
    import flash.media.Sound;
    import flash.media.SoundTransform;
    import flash.utils.Timer;

    import starling.text.TextField;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * @author Shaun Stone
     */
    public class ECG extends Sprite
    {
        public const FINE:uint = 1;
        public const WORRIED:uint = 2;
        public const TERRIFIED:uint = 3;
        private var heartRate:MovieClip;
        private var condition:TextField;
        private var heartBeat:Sound;
        private var heartBeatTransform:SoundTransform;
        private var heartbeatTimer:Timer;
        private var heartBeatInterval:int;
        //set fine by default
        private var currentState:uint = 1;

        public function ECG()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function setConditionFine():void
        {
            if (heartRate !== null) {
                heartRate.fps = 20;
                condition.color = 0x91D078;
                condition.text = "Calm";
                setCurrentState(1);
            }
        }

        public function setConditionWorried():void
        {
            if (heartRate !== null) {
                heartRate.fps = 40;
                condition.color = 0xECCD67;
                condition.text = "Uneasy";
                setCurrentState(2);
            }
        }

        public function setConditionTerrified():void
        {
            if (heartRate !== null) {
                heartRate.fps = 80;
                condition.color = 0xEC4343;
                condition.text = "Stressed";
                setCurrentState(3);
                setHeartBeatInterval(100);
            }
        }

        public function getCurrentState():uint
        {
            return currentState;
        }

        public function setCurrentState(value:uint):void
        {
            currentState = value;
        }

        public function getHeartBeatInterval():int
        {
            return heartBeatInterval;
        }

        public function setHeartBeatInterval(value:int):void
        {
            heartBeatInterval = value;
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            getSound();
            drawECG();
        }

        private function getSound():void
        {
            heartBeat = SoundAssets.heartBeat;
        }

        private function drawECG():void
        {
            heartRate = new MovieClip(ECGAssets.getAtlas().getTextures("heartrate"), 24);
            Starling.juggler.add(heartRate);
            addChild(heartRate);
            heartRate.play();
            heartRate.addEventListener("complete", onHeartRateComplete);
            condition = new TextField(123, 50, "Fine", "Verdana", 16, 0x91D078, true);
            condition.border = false;
            condition.y = 50;
            addChild(condition);
        }

        private function onHeartRateComplete(e:Event):void
        {
            if (currentState !== 1) {
                heartBeat.play();
            }
        }
    }
}