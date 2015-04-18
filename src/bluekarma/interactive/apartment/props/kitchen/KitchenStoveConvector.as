package interactive.apartment.props.kitchen
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenStoveConvector extends Prop
    {
        private var convectorOff:Image;
        private var convectorOn:Image;
        private var _running:Boolean;

        public function KitchenStoveConvector(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            // @TODO var doorOpen:String = RileyApartmentAssets.DOOR_OPEN;
            var convectorOffName:String = RileyApartmentAssets.KITCHEN_CONVECTOR;
            //@TODO
            var convectorOnName:String = RileyApartmentAssets.KITCHEN_CONVECTOR;
            //get asset
            convectorOff = new Image(RileyApartmentAssets.getAtlas().getTexture(convectorOffName));
            convectorOn = new Image(RileyApartmentAssets.getAtlas().getTexture(convectorOnName));
            //add to stage
            addChild(convectorOff);
            //hide convector on by default
            convectorOn.visible = false;
            addChild(convectorOn);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (_running) {
                turnOffConvector();
            } else {
                turnOnConvector();
            }
        }

        public function turnOnConvector():void
        {
            convectorOff.visible = false;
            convectorOn.visible = true;
        }

        public function turnOffConvector():void
        {
            convectorOff.visible = true;
            convectorOn.visible = false;
        }

        public function getRunning():Boolean
        {
            return _running;
        }

        public function setRunning(value:Boolean):void
        {
            _running = value;
        }
    }
}