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
    public class CanvasPhoto extends Prop
    {
        private var canvasPhoto:MovieClip;

        public function CanvasPhoto(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            // @TODO var doorOpen:String = RileyApartmentAssets.DOOR_OPEN;
            var canvasName:String = RileyApartmentAssets.BEDROOM_CANVAS_PHOTO;
            //create photo
            canvasPhoto = new MovieClip(RileyApartmentAssets.getAtlas().getTextures(canvasName));
            //add to stage
            addChild(canvasPhoto);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}