package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomRug extends Prop
    {
        private var rug:Image;

        public function LivingRoomRug(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var rugName:String = RileyApartmentAssets.LIVING_ROOM_RUG;
            //create rug
            rug = new Image(RileyApartmentAssets.getAtlas().getTexture(rugName));
            //add to stage
            addChild(rug);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}