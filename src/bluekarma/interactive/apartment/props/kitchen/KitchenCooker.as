package interactive.apartment.props.kitchen
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenCooker extends Prop
    {
        private var cookerOff:Image;
        private var cookerOn:Image;

        public function KitchenCooker(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            // @TODO var doorOpen:String = RileyApartmentAssets.DOOR_OPEN;
            var cookerOffName:String = RileyApartmentAssets.KITCHEN_COOKER_OFF;
            //@TODO
            var cookerOnName:String = RileyApartmentAssets.KITCHEN_COOKER_ON;
            //get asset
            cookerOff = new Image(RileyApartmentAssets.getAtlas().getTexture(cookerOffName));
            cookerOn = new Image(RileyApartmentAssets.getAtlas().getTexture(cookerOnName));
            //add to stage
            addChild(cookerOff);
            //hide convector on by default
            cookerOn.visible = false;
            addChild(cookerOn);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function turnOnOven():void
        {
            cookerOff.visible = false;
            cookerOn.visible = true;
        }

        public function turnOffOven():void
        {
            cookerOff.visible = true;
            cookerOn.visible = false;
        }
    }
}