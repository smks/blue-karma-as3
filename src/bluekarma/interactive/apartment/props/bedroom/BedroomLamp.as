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
    public class BedroomLamp extends Prop
    {
        private var bedroomLamp:MovieClip;

        public function BedroomLamp(id:String, _examinable:Boolean = false)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var lampName:String = RileyApartmentAssets.BEDROOM_LAMP_OFF;
            //create lamp
            bedroomLamp = new MovieClip(RileyApartmentAssets.getAtlas().getTextures(lampName));
            //set visible
            bedroomLamp.visible = true;
            //add to stage
            addChild(bedroomLamp);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function turnOnLight():void
        {
        }

        public function turnOffLight():void
        {
        }
    }
}