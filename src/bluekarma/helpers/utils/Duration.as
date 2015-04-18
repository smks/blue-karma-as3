package helpers.utils
{
    /**
     * ...
     * @author @shaun
     */
    public class Duration
    {
        private var duration:Number;
        private var timeStarted:Number;
        private var timeEnded:Number;
        private var timeDifference:Number;

        /**
         *
         * @param    durationToWait - seconds
         */
        public function Duration(durationToWait:Number = 1)
        {
            this.duration = durationToWait * 1000;
            trace("duration to wait", this.duration);
        }

        public function start():void
        {
            var date:Date = new Date();
            this.timeStarted = date.getTime();
            trace("time started", this.timeStarted);
        }

        public function end():void
        {
            var date:Date = new Date();
            this.timeEnded = date.getTime();
            trace("time ended", this.timeEnded);
        }

        public function waitedDuration():Boolean
        {
            this.timeDifference = this.timeEnded - this.timeStarted;
            trace("time diff", timeDifference);
            trace("time met?", Boolean(timeDifference >= duration));
            if (timeDifference >= duration) {
                return true;
            } else {
                return false;
            }
        }

        public function didntWaitLongEnough():Boolean
        {
            this.timeDifference = this.timeEnded - this.timeStarted;
            trace("time diff", timeDifference);
            trace("time met?", Boolean(timeDifference >= duration));
            if (timeDifference >= duration) {
                return false;
            } else {
                return true;
            }
        }
    }
}