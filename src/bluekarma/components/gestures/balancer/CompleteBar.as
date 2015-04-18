package components.gestures.balancer
{
    import starling.display.Quad;

    /**
     * ...
     * @author @shaun
     */
    public class CompleteBar extends Quad
    {
        private var beginPoint:Number;
        private var endPoint:Number;
        private var barComplete:Boolean = false;

        public function CompleteBar(beginPoint:Number,
                                    endPoint:Number,
                                    width:Number,
                                    height:Number,
                                    color:uint = 16777215,
                                    premultipliedAlpha:Boolean = true)
        {
            super(width, height, color, premultipliedAlpha);
            this.beginPoint = beginPoint;
            this.endPoint = endPoint;
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
            if (barComplete === true) {
                return;
            }
            if (this.width < endPoint) {
                this.width += val;
                return;
            }
            setBarComplete(true);
        }

        public function isBarComplete():Boolean
        {
            return barComplete;
        }

        public function setBarComplete(value:Boolean):void
        {
            barComplete = value;
        }
    }
}