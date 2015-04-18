package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomTelevision extends Prop
    {
        private var television:Image;

        public function LivingRoomTelevision(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var tv:String = RileyApartmentAssets.LIVING_ROOM_TV_OFF;
            //create bed
            television = new Image(RileyApartmentAssets.getAtlas().getTexture(tv));
            //add to stage
            addChild(television);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}