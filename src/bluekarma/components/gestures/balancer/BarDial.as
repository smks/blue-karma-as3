package components.gestures.balancer
{
    import global.Global;

    import starling.display.Quad;

    /**
     * ...
     * @author @shaun
     */
    public class BarDial extends Quad
    {
        private var beginPoint:Number;
        private var beginMidPoint:Number;
        private var midPoint:Number;
        private var midEndPoint:Number;
        private var endPoint:Number;
        private var acceleration:Number = 0;
        private var hasFailedInRed:Boolean;

        public function BarDial(beginPoint:Number, endPoint:Number, width:Number, height:Number, color:uint = 16777215, premultipliedAlpha:Boolean = true)
        {
            super(width, height, color, premultipliedAlpha);
            this.beginPoint = beginPoint;
            this.endPoint = endPoint;
            this.midPoint = calculateMidPoint();
            this.beginMidPoint = calculateBeginMidPoint();
            this.midEndPoint = calculateMidEndPoint();
        }

        public function setBeginPoint(point:Number):void
        {
            this.beginPoint = point;
        }

        public function setEndPoint(point:Number):void
        {
            this.endPoint = point;
        }

        public function increase(val:Number):void
        {
            if (this.x < endPoint) {
                this.x += val * 1.1;
            }
            if (this.x > endPoint) {

                // they have hit the red endpoint meaning they have failed
                this.setInRed(true);
                this.x = endPoint;
            }
        }

        public function decrease(val:Number):void
        {
            if (this.x > beginPoint) {
                this.x -= val * 1.1;
            }
            if (this.x < beginPoint) {
                this.x = beginPoint;
            }
        }

        public function isGreaterThanMidPoint():Boolean
        {
            if (this.x >= midPoint) {
                return true;
            }
            return false;
        }

        public function isLessThanMidPoint():Boolean
        {
            if (this.x < midPoint) {
                return true;
            }
            return false;
        }

        public function isGreaterThanBeginMidPoint():Boolean
        {
            if (this.x >= beginMidPoint) {
                return true;
            }
            return false;
        }

        public function isLessThanBeginMidPoint():Boolean
        {
            if (this.x < beginMidPoint) {
                return true;
            }
            return false;
        }

        public function isGreaterThanMidEndPoint():Boolean
        {
            if (this.x >= midEndPoint) {
                return true;
            }
            return false;
        }

        public function isLessThanBeginMidEndPoint():Boolean
        {
            if (this.x < beginMidPoint) {
                return true;
            }
            return false;
        }

        public function getMidPoint():Number
        {
            return midPoint;
        }

        public function getBeginMidPoint():Number
        {
            return beginMidPoint;
        }

        public function setBeginMidPoint(value:Number):void
        {
            beginMidPoint = value;
        }

        public function getMidEndPoint():Number
        {
            return midEndPoint;
        }

        public function setMidEndPoint(value:Number):void
        {
            midEndPoint = value;
        }

        public function getAcceleration():Number
        {
            if (this.x <= beginPoint) {
                return 0;
            }
            if (this.x >= endPoint) {
                return 0;
            }
            return this.x * 0.004;
        }

        public function inRed():Boolean
        {
            return hasFailedInRed;
        }

        private function calculateBeginMidPoint():Number
        {
            var num:Number = midPoint - beginPoint;
            return beginMidPoint = num / 2;
        }

        private function calculateMidEndPoint():Number
        {
            return midEndPoint = endPoint - beginMidPoint;
        }

        private function calculateMidPoint():Number
        {
            return midPoint = (endPoint / 2) + (this.width * 3);
        }

        private function setInRed(boolean:Boolean):void
        {
            this.hasFailedInRed = boolean;
        }
    }
}