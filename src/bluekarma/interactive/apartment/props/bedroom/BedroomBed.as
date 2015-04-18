package interactive.apartment.props.bedroom
{
    import bluekarma.assets.sound.SoundAssets;

    import interactive.base.Prop;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.apartment.repos.ApartmentInteractionRepo;

    import bluekarma.interactive.base.InteractionObject;

    import starling.display.Image;
    import starling.display.MovieClip;

    import assets.RileyApartmentAssets;

    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     */
    public class BedroomBed extends Prop
    {
        private var _bed:Image;
        private var _bedCoverDone:Image;
        private var _bedCoverUndone:Image;
        private var _bedMade:Boolean = false;

        /**
         *
         * @param    id
         * @param    examinable
         */

        public function BedroomBed(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            
            _repo = new ApartmentInteractionRepo();
        }

        /**
         *
         * @param    id
         */

        override protected function getPropAsset(id:String):void
        {
            var _bedName:String = RileyApartmentAssets.BED;
            var _bedCoverDoneName:String = RileyApartmentAssets.BEDROOM_COVER_DONE;
            var _bedCoverUndoneName:String = RileyApartmentAssets.BEDROOM_COVER_UNDONE;
            //create bed
            _bed = new Image(RileyApartmentAssets.getAtlas().getTexture(_bedName));
            _bedCoverDone = new Image(RileyApartmentAssets.getAtlas().getTexture(_bedCoverDoneName));
            _bedCoverUndone = new Image(RileyApartmentAssets.getAtlas().getTexture(_bedCoverUndoneName));
            _bed.visible = true;
            _bedCoverDone.visible = false;
            _bedCoverUndone.visible = true;
            _bedCoverDone.x = 40;
            _bedCoverDone.y = 95;
            _bedCoverUndone.x = 90;
            _bedCoverUndone.y = 180;
            //add to stage
            addChild(_bed);
            addChild(_bedCoverDone);
            addChild(_bedCoverUndone);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            SoundAssets.clothingPickup.play();
            if (!_bedMade) {
                makeBed();
            } else {
                unMakeBed();
            }
        }

        public function makeBed():void
        {
            if (_bedCoverDone.visible) {
                return;
            }
            _bedCoverDone.visible = true;
            _bedCoverUndone.visible = false;
            setBedMade(true);
        }

        public function unMakeBed():void
        {
            if (_bedCoverUndone.visible) {
                return;
            }
            _bedCoverUndone.visible = true;
            _bedCoverDone.visible = false;
            setBedMade(false);
        }

        public function hideCovers():void
        {
            _bedCoverUndone.visible = false;
            _bedCoverDone.visible = false;
        }

        public function isBedMade():Boolean
        {
            return _bedMade;
        }

        public function setBedMade(value:Boolean):void
        {
            _bedMade = value;
        }
    }
}