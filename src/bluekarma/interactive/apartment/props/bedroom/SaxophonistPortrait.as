package interactive.apartment.props.bedroom
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;
    import starling.utils.deg2rad;

    /**
     * ...
     * @author Shaun Stone
     */
    public class SaxophonistPortrait extends Prop
    {
        private var photo:Image;

        public function SaxophonistPortrait(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            // @TODO var doorOpen:String = RileyApartmentAssets.DOOR_OPEN;
            var name:String = RileyApartmentAssets.BEDROOM_SAX_PHOTO;
            //create photo
            photo = new Image(RileyApartmentAssets.getAtlas().getTexture(name));
            //add to stage
            addChild(photo);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}