package helpers
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    import starling.display.Sprite;
    import starling.events.Event;

    import states.Level1State;

    /**
     * ...
     * @author Shaun Stone
     */
    public class GameClock
    {
        public const SECONDS:uint = 1000;
        private var clockTimer:Timer;
        private var level:String;

        public function GameClock()
        {
            setUpClock();
        }

        public function stopClock():void
        {
            clockTimer.stop();
        }

        private function setUpClock():void
        {
            //level1
            clockTimer = new Timer(1000, 0);
            clockTimer.addEventListener(TimerEvent.TIMER, updateClock);
            clockTimer.start();
        }

        private function updateClock(e:TimerEvent):void
        {
            Level1State.CLOCK.time += SECONDS;
        }
    }
}