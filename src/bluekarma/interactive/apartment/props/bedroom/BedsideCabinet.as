package interactive.apartment.props.bedroom
{
    import interactive.base.Prop;

    import bluekarma.interactive.general.items.LockPick;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;

    /**
     * ...
     * @author Shaun Stone
     */
    public class BedsideCabinet extends Prop
    {
        private var bedsideCabinet:MovieClip;
        private var gotLockPick:Boolean = false;
        private var lockPick:LockPick;

        public function BedsideCabinet(id:String, _examinable:Boolean = false)
        {
            super(id, _examinable);
            
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        override protected function getPropAsset(id:String):void
        {
            var bedsideCabinetName:String = RileyApartmentAssets.BEDROOM_BEDSIDE_CABINET;
            //create cabinet
            bedsideCabinet = new MovieClip(RileyApartmentAssets.getAtlas().getTextures(bedsideCabinetName));
            //set visible
            bedsideCabinet.visible = true;
            //add to stage
            addChild(bedsideCabinet);
        }

        public function hasLockPick():Boolean
        {
            return gotLockPick;
        }

        public function getLockPick():LockPick
        {
            if (lockPick == null) {
                trace("lockpick is null, creating now");
                lockPick = new LockPick("lockpick", true);
                setHasLockPick(true);
            }
            trace("returning lockpick");
            return lockPick;
        }

        public function openDrawer1():void
        {
        }

        public function openDrawer2():void
        {
        }

        private function setHasLockPick(val:Boolean):void
        {
            gotLockPick = val;
        }
    }
}