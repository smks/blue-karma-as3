package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomCurtains extends Prop
    {
        private var curtainsOpen:Image;
        private var curtainsClosed:Image;

        public function LivingRoomCurtains(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            // @TODO var doorOpen:String = RileyApartmentAssets.DOOR_OPEN;
            var curtainsOpenName:String = RileyApartmentAssets.LIVING_ROOM_CURTAINS_OPEN;
            var curtainsClosedName:String = RileyApartmentAssets.LIVING_ROOM_CURTAINS_CLOSED;
            trace(curtainsOpenName);
            trace(curtainsClosedName);
            //create bed
            curtainsOpen = new Image(RileyApartmentAssets.getAtlas().getTexture(curtainsOpenName));
            curtainsClosed = new Image(RileyApartmentAssets.getAtlas().getTexture(curtainsClosedName));
            curtainsOpen.visible = false;
            curtainsClosed.visible = true;
            //add to stage
            addChild(curtainsOpen);
            addChild(curtainsClosed);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function openCurtains():void
        {
            if (curtainsOpen.visible == true) {
                return;
            }
            curtainsOpen.visible = true;
            curtainsClosed.visible = false;
        }

        public function closeCurtains():void
        {
            if (curtainsClosed.visible == true) {
                return;
            }
            curtainsOpen.visible = false;
            curtainsClosed.visible = true;
        }
    }
}