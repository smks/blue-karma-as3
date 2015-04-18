package interactive.apartment.props.bedroom
{
    import bluekarma.assets.sound.SoundAssets;

    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Lightswitch extends Prop
    {
        protected var lightsOn:Boolean = false;
        private var lightSwitchOn:MovieClip;
        private var lightSwitchOff:MovieClip;

        public function Lightswitch(id:String, _examinable:Boolean = false)
        {
            super(id, _examinable);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            trace("triggerInteractionObject for light switch");
            if (lightsOn) {
                turnOffLight();
                lightsOn = false;
            } else {
                turnOnLight();
                lightsOn = true;
            }
        }

        override protected function getPropAsset(id:String):void
        {
            var switchOn:String = RileyApartmentAssets.BEDROOM_SWITCH_ON;
            var switchOff:String = RileyApartmentAssets.BEDROOM_SWITCH_OFF;
            //create lightswitch
            lightSwitchOn = new MovieClip(RileyApartmentAssets.getAtlas().getTextures(switchOn));
            lightSwitchOff = new MovieClip(RileyApartmentAssets.getAtlas().getTextures(switchOff));
            lightSwitchOff.visible = true;
            lightSwitchOn.visible = false;
            //add to stage
            addChild(lightSwitchOn);
            addChild(lightSwitchOff);
        }

        public function turnOnLight():void
        {

            //create light switch sound
            SoundAssets.apartmentLightSwitchOn.play();
            lightSwitchOn.visible = true;
            lightSwitchOff.visible = false;
            toggleLighting();
        }

        public function turnOffLight():void
        {

            //create light switch sound
            SoundAssets.apartmentLightSwitchOff.play();
            lightSwitchOff.visible = true;
            lightSwitchOn.visible = false;
            toggleLighting();
        }

        public function toggleLighting():void
        {
            trace("dispatched event to toggle light");
            //send event to toggle lighting
            dispatchEventWith("lightSwitchToggle", true, {id: this._id, object: this});
        }
    }
}