//@TODO Merge this into cupboard light
package interactive.apartment.props.kitchen
{
    import interactive.base.Prop;

    import bluekarma.assets.sound.SoundAssets;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenDarkCupboard extends Prop
    {
        protected var _open:Boolean = false;
        private var cupboardOpen:Image;
        private var cupboardClosed:Image;

        public function KitchenDarkCupboard(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var cupboardClosedName:String
            var cupboardOpenName:String
            if (_id == "kitchen_dark_cupboard_1") {
                cupboardClosedName = RileyApartmentAssets.KITCHEN_DARK_CUPBOARD_SIDE_CLOSED;
                cupboardOpenName = RileyApartmentAssets.KITCHEN_DARK_CUPBOARD_SIDE_OPEN;
            } else {
                cupboardClosedName = RileyApartmentAssets.KITCHEN_DARK_CUPBOARD_CLOSED;
                cupboardOpenName = RileyApartmentAssets.KITCHEN_DARK_CUPBOARD_OPEN;
            }
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
            if (this._open) {
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