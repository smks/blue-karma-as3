package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomDogBed extends Prop
    {
        private var bed:Image;

        public function LivingRoomDogBed(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            
        }

        override protected function getPropAsset(id:String):void
        {
            var bedName:String = RileyApartmentAssets.LIVING_ROOM_DOG_BED;
            //create rug
            bed = new Image(RileyApartmentAssets.getAtlas().getTexture(bedName));
            //add to stage
            addChild(bed);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}