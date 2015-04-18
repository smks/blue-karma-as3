package interactive.apartment.props.bedroom
{
    import bluekarma.assets.sound.SoundAssets;

    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;

    /**
     * ...
     * @author Shaun Stone
     */
    public class BedsideChest extends Prop
    {
        private var bedsideChest:MovieClip;
        private var drawer1:Image;
        private var drawer2:Image;
        private var drawer3:Image;
        private var _drawOpen:Boolean = false;

        public function BedsideChest(id:String, _examinable:Boolean = false)
        {
            super(id, _examinable);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (_drawOpen) {
                closeDrawer();
            } else {
                openDrawer();
            }
        }

        override protected function getPropAsset(id:String):void
        {
            var bedsideChestName:String = RileyApartmentAssets.BEDROOM_CHEST;
            var bedsideChestDrawerName:String = RileyApartmentAssets.BEDROOM_CHEST_DRAW;
            //create cabinet
            bedsideChest = new MovieClip(RileyApartmentAssets.getAtlas().getTextures(bedsideChestName));
            addChild(bedsideChest);
            drawer1 = new Image(RileyApartmentAssets.getAtlas().getTexture(bedsideChestDrawerName));
            drawer1.x = 22;
            drawer1.y = 33;
            addChild(drawer1);
            drawer2 = new Image(RileyApartmentAssets.getAtlas().getTexture(bedsideChestDrawerName));
            drawer2.x = 22;
            drawer2.y = 85;
            addChild(drawer2);
            drawer3 = new Image(RileyApartmentAssets.getAtlas().getTexture(bedsideChestDrawerName));
            drawer3.x = 22;
            drawer3.y = 136;
            addChild(drawer3);
        }

        public function openDrawer():void
        {
            SoundAssets.apartmentBedroomChestOpen.play();
            setDrawOpen(true);
            drawer1.scaleX = 1.2;
            drawer1.scaleY = 1.2;
            setPosition();
        }

        public function closeDrawer():void
        {
            SoundAssets.apartmentBedroomChestClose.play();
            setDrawOpen(false);
            setPosition();
            drawer1.scaleX = 1;
            drawer1.scaleY = 1;
        }

        public function getDrawOpen():Boolean
        {
            return _drawOpen;
        }

        private function setPosition():void
        {
            if (_drawOpen) {
                drawer1.x -= (drawer1.width / 12);
            } else {
                drawer1.x += (drawer1.width / 12);
            }
        }

        private function setDrawOpen(val:Boolean):void
        {
            _drawOpen = val;
        }
    }
}