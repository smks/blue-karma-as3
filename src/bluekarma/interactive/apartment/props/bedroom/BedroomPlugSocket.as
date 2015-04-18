package interactive.apartment.props.bedroom
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;

    /**
     * ...
     * @author Shaun Stone
     */
    public class BedroomPlugSocket extends Prop
    {
        private var plugSocket:MovieClip;

        public function BedroomPlugSocket(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var socketName:String = RileyApartmentAssets.BEDROOM_PLUGS;
            //create bed
            plugSocket = new MovieClip(RileyApartmentAssets.getAtlas().getTextures(socketName));
            //add to stage
            addChild(plugSocket);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function plug():void
        {
        }

        public function unplug():void
        {
        }
    }
}