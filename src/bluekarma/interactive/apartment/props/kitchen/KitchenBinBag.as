package interactive.apartment.props.kitchen
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenBinBag extends Prop
    {
        private var binBagClosed:Image;
        private var binBagOpen:Image;

        public function KitchenBinBag(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            // @TODO var doorOpen:String = RileyApartmentAssets.DOOR_OPEN;
            var binBagClosedName:String = RileyApartmentAssets.KITCHEN_BINBAG_OPEN;
            var binBagOpenName:String = RileyApartmentAssets.KITCHEN_BINBAG_OPEN;
            //@TODO
            binBagClosed = new Image(RileyApartmentAssets.getAtlas().getTexture(binBagClosedName));
            //get bin bag open image
            binBagOpen = new Image(RileyApartmentAssets.getAtlas().getTexture(binBagClosedName));
            //add to stage
            addChild(binBagClosed);
            //hide open bag by default
            binBagOpen.visible = false;
            addChild(binBagOpen);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function openBin():void
        {
            binBagClosed.visible = false;
            binBagOpen.visible = true;
        }

        public function closeBin():void
        {
            binBagClosed.visible = true;
            binBagOpen.visible = false;
        }
    }
}