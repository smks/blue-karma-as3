package interactive.apartment.props.general
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
    public class Door extends Prop
    {
        private var doorClosed:Image;
        private var doorOpen:Image;
        private var _isDoorOpen:Boolean = false;

        public function Door(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
            
        }

        override protected function getPropAsset(id:String):void
        {
            var doorOpenName:String = RileyApartmentAssets.DOOR_OPEN;
            var doorClosedName:String = RileyApartmentAssets.DOOR_CLOSED;
            //create door
            doorOpen = new Image(RileyApartmentAssets.getAtlas().getTexture(doorOpenName));
            doorClosed = new Image(RileyApartmentAssets.getAtlas().getTexture(doorClosedName));
            //add to stage
            addChild(doorClosed);
            //doors are shut by default
            doorOpen.visible = false;
            addChild(doorOpen);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (_isDoorOpen) {
                closeDoor();
            } else {
                openDoor();
            }
        }
		
		override public function triggerExamine(params:Object = null):void 
		{
			super.triggerExamine(params);
		}

        public function openDoor():void
        {
            SoundAssets.apartmentDoorOpen.play();
            doorClosed.visible = false;
            doorOpen.visible = true;
            setIsDoorOpen(true);
        }

        public function closeDoor():void
        {
            SoundAssets.apartmentDoorClose.play();
            doorClosed.visible = true;
            doorOpen.visible = false;
            setIsDoorOpen(false);
        }

        public function getIsDoorOpen():Boolean
        {
            return _isDoorOpen;
        }

        public function setIsDoorOpen(value:Boolean):void
        {
            _isDoorOpen = value;
        }
    }
}