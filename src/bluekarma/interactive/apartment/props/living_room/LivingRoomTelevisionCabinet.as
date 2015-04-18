package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomTelevisionCabinet extends Prop
    {
        private var televisionCabinet:Image;

        public function LivingRoomTelevisionCabinet(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var cabinetName:String = RileyApartmentAssets.LIVING_ROOM_TV_CABINET;
            //create bed
            televisionCabinet = new Image(RileyApartmentAssets.getAtlas().getTexture(cabinetName));
            //add to stage
            addChild(televisionCabinet);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}