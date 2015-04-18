package interactive.apartment.props.kitchen
{
    import interactive.base.Prop;

    import starling.core.Starling;
    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenSink extends Prop
    {
        private var sinkOff:Image;
        private var sinkOn:Image;
        private var waterAnim:MovieClip;
        private var _running:Boolean = false;

        public function KitchenSink(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var sinkOffName:String = RileyApartmentAssets.KITCHEN_SINK_OFF;
            var sinkOnName:String = RileyApartmentAssets.KITCHEN_SINK_OFF;
            //get asset
            sinkOff = new Image(RileyApartmentAssets.getAtlas().getTexture(sinkOffName));
            //@TODO
            sinkOn = new Image(RileyApartmentAssets.getAtlas().getTexture(sinkOffName));
            //add to stage
            addChild(sinkOff);
            //hide open bag by default
            sinkOn.visible = false;
            addChild(sinkOn);
            drawTapAnimation();
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (_running) {
                turnOffSink();
            } else {
                turnOnSink();
            }
        }

        public function turnOnSink():void
        {
            sinkOff.visible = false;
            sinkOn.visible = true;
            turnOnTapWater();
        }

        public function turnOffSink():void
        {
            sinkOff.visible = true;
            sinkOn.visible = false;
            turnOffTapWater();
        }

        public function getRunning():Boolean
        {
            return _running;
        }

        public function setRunning(value:Boolean):void
        {
            _running = value;
        }

        public function tapRunning():Boolean
        {
            return getRunning();
        }

        private function drawTapAnimation():void
        {
            waterAnim = new MovieClip(RileyApartmentAssets.getAtlas().getTextures("tap_water"));
            Starling.juggler.add(waterAnim);
            waterAnim.x = 62;
            waterAnim.y = 36;
            waterAnim.scaleX = 1.4;
            waterAnim.scaleY = 1.5;
            turnOffTapWater();
            addChild(waterAnim);
        }

        private function turnOffTapWater():void
        {
            waterAnim.stop();
            waterAnim.visible = false;
            setRunning(false);
        }

        private function turnOnTapWater():void
        {
            waterAnim.play();
            waterAnim.visible = true;
            setRunning(true);
        }
    }
}