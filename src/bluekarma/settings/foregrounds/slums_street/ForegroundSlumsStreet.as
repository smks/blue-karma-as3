package settings.foregrounds.slums_street
{
    import bluekarma.interactive.slumsstreet.props.CCTV;

    import settings.AbstractSetting;

    import starling.display.BlendMode;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.display.Image;

    import assets.Level1Assets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class ForegroundSlumsStreet extends AbstractSetting
    {
        protected var _foregroundName:String;
        //classes
        protected var _cctv1:CCTV;
        protected var _cctv2:CCTV;
        //images
        protected var _foregroundLightsOn:Image;
        protected var _foregroundLightsOff:Image;
        protected var _car1:Image;
        protected var _car2:Image;
        protected var _bins:Image;
        private var _streetLight1:StreetLight;
        private var _streetLight2:StreetLight;

        public function ForegroundSlumsStreet(position:uint = 1)
        {
            super(position);
        }

        override protected function composeSetting():void
        {
            //draw assets
            drawSetting();
            //set the position
            setCurrentPosition(_currentPosition);
        }

        override protected function drawSetting():void
        {
            /**
             * Add 1st section props
             */
            _car1 = new Image(Level1Assets.getAtlas().getTexture("car_1"));
            _car1.x = 0;
            _car1.y = 467;
            _car1.touchable = false;
            addChild(_car1);
            _car2 = new Image(Level1Assets.getAtlas().getTexture("car_2"));
            _car2.x = 2194;
            _car2.y = 467;
            _car2.touchable = false;
            addChild(_car2);
            /**
             * Add second section props
             *
             * @TODO
             */
            /**
             * Add third option props
             */
            _cctv2 = new CCTV("cctv2", true);
            _cctv2.x = 2300;
            _cctv2.y = 200;
            _cctv2.touchable = true;
            addChild(_cctv2);
			
            _streetLight1 = new StreetLight();
            _streetLight1.x = 702;
            _streetLight1.y = 142;
            addChild(_streetLight1);
			
            _streetLight2 = new StreetLight();
            _streetLight2.x = 1350;
            _streetLight2.y = 142;
            addChild(_streetLight2);
			
            _foregroundLightsOn = new Image(Level1Assets.getTexture("SlumsForegroundLightsOn"));
            _foregroundLightsOn.scaleX = 8;
            _foregroundLightsOn.scaleY = 8;
            addChild(_foregroundLightsOn);
            turnOnLights();
            /**
             * Add alley 1 prop (bins)
             *

             _bins = new Image(Level1Assets.getTexture("SlumsAlleyBins"));
             _bins.x = 0;
             _bins.y = 1217;
             _bins.touchable = false;
             addChild(_bins);
             */
        }

        override public function setCurrentPosition(_pos:uint):void
        {
            _currentPosition = _pos;
            //set position of background
            if (_pos == 0) {
                this.x = 0;
                this.y = -768;
            } else if (_pos == 1) {
                this.x = 0;
                this.y = 0;
            } else if (_pos == 2) {
                this.x = -853;
                this.y = 0;
            } else if (_pos == 3) {
                this.x = -2560 + stage.stageWidth;
                this.y = 0;
            } else {
                return;
            }
        }

        public function turnOnLights():void
        {
            if (_foregroundLightsOff !== null) {
                _foregroundLightsOff.visible = false;
                _foregroundLightsOn.visible = true;
                _streetLight1.turnOn();
                _streetLight2.turnOn();
                if (_cctv1 !== null) {
                    _cctv1.startMovement();
                }
                if (_cctv2 !== null) {
                    _cctv2.startMovement();
                }
            }
        }

        public function turnOffLights():void
        {
            if (_foregroundLightsOn !== null) {
                _foregroundLightsOff.visible = true;
                _foregroundLightsOn.visible = false;
                _streetLight1.turnOff();
                _streetLight2.turnOff();
                if (_cctv1 !== null) {
                    _cctv1.stopMovement();
                }
                if (_cctv2 !== null) {
                    _cctv2.stopMovement();
                }
            }
        }
    }
}