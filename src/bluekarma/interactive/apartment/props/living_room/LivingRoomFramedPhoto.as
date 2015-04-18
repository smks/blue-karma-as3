package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomFramedPhoto extends Prop
    {
        protected var photo:Image;

        public function LivingRoomFramedPhoto(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var photoName:String = RileyApartmentAssets.LIVING_ROOM_PHOTO;
            //create rug
            photo = new Image(RileyApartmentAssets.getAtlas().getTexture(photoName));
            //add to stage
            addChild(photo);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}