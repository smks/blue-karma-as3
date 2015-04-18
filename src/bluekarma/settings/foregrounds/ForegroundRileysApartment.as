package settings.foregrounds
{
    import assets.RileyApartmentAssets;

    import bluekarma.interactive.base.Item;

    import com.greensock.loading.data.ImageLoaderVars;

    import settings.AbstractSetting;
    import settings.base.Foreground;

    import starling.display.BlendMode;
    import starling.display.MovieClip;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.display.Image;

    import assets.Level1Assets;
    import assets.Level1CharacterAssets;

    import bluekarma.assets.sound.SoundAssets;

    import starling.core.Starling;
    import starling.display.Button;

    import events.InteractionEvent;

    /**
     * ...
     * @author Shaun Stone
     */
    public class ForegroundRileysApartment extends Foreground
    {
        public static const KITCHEN:String = "kitchen";
        public static const LIVING_ROOM:String = "living_room";
        public static const BEDROOM:String = "bedroom";
        //determines if it is the day or not
        public static var _dayTime:Boolean = false;
        /**
         * @desc this determines that if it is during the day the lights can not be turned on
         */
        protected var currentTimeZone:String;
        private var _kitchenDaylight:Image;
        private var _kitchenLightsOn:Image;
        private var _kitchenDark:Image;
        private var _livingroomDaylight:Image;
        private var _livingroomLightsOn:Image;
        private var _livingroomDark:Image;
        private var _bedroomDaylight:Image;
        private var _bedroomLightsOn:Image;
        private var _bedroomLightsDark:Image;
        private var _bedroomLightsShade:Image;
        private var _bedroomLightOn:Boolean = false;

        public function ForegroundRileysApartment(position:uint = 1)
        {
            super(position);
            composeSetting();
        }

        override protected function composeSetting():void
        {
            drawSetting();
        }

        override protected function drawSetting():void
        {
            _kitchenDaylight = new Image(RileyApartmentAssets.getTexture("KitchenDaylight"));
            _kitchenDaylight.x = 0;
            _kitchenDaylight.y = 0;
            _kitchenDaylight.visible = false;
            addChild(_kitchenDaylight);
            _kitchenDaylight.touchable
            _kitchenLightsOn = new Image(RileyApartmentAssets.getTexture("KitchenLightsOn"));
            _kitchenLightsOn.x = 0;
            _kitchenLightsOn.y = 0;
            _kitchenLightsOn.visible = false;
            addChild(_kitchenLightsOn);
            _kitchenDark = new Image(RileyApartmentAssets.getTexture("KitchenDark"));
            _kitchenDark.x = 0;
            _kitchenDark.y = 0;
            _kitchenDark.blendMode = BlendMode.MULTIPLY;
            _kitchenDark.visible = true;
            addChild(_kitchenDark);
            _livingroomDaylight = new Image(RileyApartmentAssets.getTexture("LivingroomDaylight"));
            _livingroomDaylight.x = Game.STAGE_WIDTH;
            _livingroomDaylight.y = 0;
            _livingroomDaylight.visible = false;
            addChild(_livingroomDaylight);
            _livingroomLightsOn = new Image(RileyApartmentAssets.getTexture("LivingroomLightsOn"));
            _livingroomLightsOn.x = Game.STAGE_WIDTH;
            _livingroomLightsOn.y = 0;
            _livingroomLightsOn.visible = false;
            addChild(_livingroomLightsOn);
            _livingroomDark = new Image(RileyApartmentAssets.getTexture("LivingroomDark"));
            _livingroomDark.x = Game.STAGE_WIDTH;
            _livingroomDark.y = 0;
            _livingroomDark.blendMode = BlendMode.MULTIPLY;
            _livingroomDark.visible = true;
            addChild(_livingroomDark);
            _bedroomLightsShade = new Image(RileyApartmentAssets.getTexture("BedroomShade"));
            _bedroomLightsShade.x = (Game.STAGE_WIDTH * 2);
            _bedroomLightsShade.y = 0;
            _bedroomLightsShade.visible = true;
            _bedroomLightsShade.blendMode = BlendMode.MULTIPLY;
            addChild(_bedroomLightsShade);
            _bedroomDaylight = new Image(RileyApartmentAssets.getTexture("BedroomDaylight"));
            _bedroomDaylight.x = (Game.STAGE_WIDTH * 2);
            _bedroomDaylight.y = 0;
            _bedroomDaylight.visible = false;
            addChild(_bedroomDaylight);
            _bedroomLightsOn = new Image(RileyApartmentAssets.getTexture("BedroomLightsOn"));
            _bedroomLightsOn.x = (Game.STAGE_WIDTH * 2);
            _bedroomLightsOn.y = 0;
            _bedroomLightsOn.visible = false;
            addChild(_bedroomLightsOn);
            _bedroomLightsDark = new Image(RileyApartmentAssets.getTexture("BedroomDark"));
            _bedroomLightsDark.x = (Game.STAGE_WIDTH * 2);
            _bedroomLightsDark.y = 0;
            _bedroomLightsDark.blendMode = BlendMode.MULTIPLY;
            _bedroomLightsDark.visible = false;
            addChild(_bedroomLightsDark);
            setCurrentPosition(this._currentPosition);
        }

        public function toggleLighting():void
        {
            if (!_bedroomLightOn) {
                turnOnBedroomLights();
                _bedroomLightOn = true;
            } else {
                turnOffBedroomLights();
                _bedroomLightOn = false;
            }
        }

        public function turnOffKitchenLights():void
        {
            _kitchenDaylight.visible = false;
            _kitchenLightsOn.visible = false;
            _kitchenDark.visible = true;
        }

        public function turnOffLivingroomLights():void
        {
            _livingroomDaylight.visible = false;
            _livingroomLightsOn.visible = false;
            _livingroomDark.visible = true;
        }

        public function turnOffBedroomLights():void
        {
            _bedroomDaylight.visible = false;
            _bedroomLightsOn.visible = false;
            _bedroomLightsDark.visible = true;
            _bedroomLightsShade.visible = true;
        }

        public function turnOnKitchenLights():void
        {
            _kitchenDaylight.visible = false;
            _kitchenLightsOn.visible = true;
            _kitchenDark.visible = false;
        }

        public function turnOnLivingroomLights():void
        {
            _livingroomDaylight.visible = false;
            _livingroomLightsOn.visible = true;
            _livingroomDark.visible = false;
        }

        public function turnOnBedroomLights():void
        {
            _bedroomDaylight.visible = false;
            _bedroomLightsOn.visible = true;
            _bedroomLightsDark.visible = false;
            _bedroomLightsShade.visible = false;
        }

        public function daylightKitchen():void
        {
            _kitchenDaylight.visible = true;
            _kitchenLightsOn.visible = false;
            _kitchenDark.visible = false;
        }

        public function daylightLivingroom():void
        {
            _livingroomDaylight.visible = true;
            _livingroomLightsOn.visible = false;
            _livingroomDark.visible = false;
        }

        public function daylightBedroom():void
        {
            _bedroomDaylight.visible = true;
            _bedroomLightsOn.visible = false;
            _bedroomLightsDark.visible = false;
            _bedroomLightsShade.visible = false;
        }

        public function setToDaytime():void
        {
            _dayTime = true;
        }

        public function setToNightime():void
        {
            _dayTime = true;
        }

        public function isDayTime():Boolean
        {
            return _dayTime;
        }

        public function isBedroomLightOn():Boolean
        {
            return _bedroomLightOn;
        }

        public function setBedroomLightOn(value:Boolean):void
        {
            _bedroomLightOn = value;
        }
    }
}