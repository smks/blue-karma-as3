package interactive.apartment.props.kitchen
{
    import bluekarma.assets.sound.SoundAssets;

    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenLightCupboard extends Prop
    {
        protected var _open:Boolean = false;
        private var cupboardOpen:Image;
        private var cupboardClosed:Image;

        public function KitchenLightCupboard(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            // @TODO var doorOpen:String = RileyApartmentAssets.DOOR_OPEN;
            var cupboardClosedName:String = RileyApartmentAssets.KITCHEN_LIGHT_CUPBOARD_CLOSED;
            var cupboardOpenName:String = RileyApartmentAssets.KITCHEN_LIGHT_CUPBOARD_OPEN;
            //@TODO
            cupboardClosed = new Image(RileyApartmentAssets.getAtlas().getTexture(cupboardClosedName));
            //get bin bag open image
            cupboardOpen = new Image(RileyApartmentAssets.getAtlas().getTexture(cupboardOpenName));
            //add to stage
            addChild(cupboardClosed);
            //hide open bag by default
            cupboardOpen.visible = false;
            addChild(cupboardOpen);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (_open) {
                closeCupboard();
            } else {
                openCupboard();
            }
        }

        public function openCupboard():void
        {
            SoundAssets.kitchenCupboardOpen.play();
            cupboardClosed.visible = false;
            cupboardOpen.visible = true;
            cupboardClosed.touchable = true;
            cupboardOpen.touchable = false;
            setOpen(true);
        }

        public function closeCupboard():void
        {
            SoundAssets.kitchenCupboardClose.play();
            cupboardClosed.visible = true;
            cupboardOpen.visible = false;
            cupboardClosed.touchable = false;
            cupboardOpen.touchable = true;
            setOpen(false);
        }

        public function getOpen():Boolean
        {
            return _open;
        }

        public function setOpen(value:Boolean):void
        {
            _open = value;
        }
    }
}