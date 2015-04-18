package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomSofa extends Prop
    {
        private var sofaOff:Image;

        public function LivingRoomSofa(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var sofaName:String = RileyApartmentAssets.LIVING_ROOM_SOFA_OFF;
            //create rug
            sofaOff = new Image(RileyApartmentAssets.getAtlas().getTexture(sofaName));
            //add to stage
            addChild(sofaOff);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}