package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomWelcomeMatt extends Prop
    {
        private var matt:Image;

        public function LivingRoomWelcomeMatt(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var mattName:String = RileyApartmentAssets.LIVING_ROOM_WELCOME_MATT;
            //create rug
            matt = new Image(RileyApartmentAssets.getAtlas().getTexture(mattName));
            //add to stage
            addChild(matt);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}