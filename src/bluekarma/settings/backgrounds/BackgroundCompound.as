package bluekarma.settings.backgrounds
{
    import assets.CompoundAssets;

    import bluekarma.interactive.compound.RileyCable;
    import bluekarma.interactive.compound.characters.Dawson;
    import bluekarma.interactive.compound.items.MaskingTape;

    import interactive.compound.props.Backpack;
    import interactive.compound.props.Cabinet;
    import interactive.compound.props.Chair;
    import interactive.compound.props.Corkboard;
    import interactive.compound.props.Door;
    import interactive.compound.props.IncognitiveMask;
    import interactive.compound.props.Mirror;
    import interactive.compound.props.PlasticBag;
    import interactive.compound.props.Sofa;
    import interactive.compound.props.Stationary;
    import interactive.compound.props.Window;

    import settings.AbstractSetting;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * Class BackgroundCompound
     * @author Shaun M.K Stone (SMKS)
     * @website http://www.smks.co.uk
     * Created at: 08-01-2015 14:28:27
     */
    public class BackgroundCompound extends AbstractSetting
    {
        public static const POSITION_1:Number = 1;
        public const BG_IMAGE_NAME:String = 'CompoundBackgroundImage';
        /**
         * List of Interaction Objects
         */
        private var _corkboard:Corkboard;
        private var _plasticBag:PlasticBag;
        private var _door:Door;
        private var _cabinet:Cabinet;
        private var _window:Window;
        private var _backpack:Backpack;
        private var _chair:Chair;
        private var _incognitiveMask:IncognitiveMask;
        private var _mirror:Mirror;
        private var _sofa:Sofa;
        private var _stationary:Stationary;
        private var _maskingTape:MaskingTape;
        private var dawson:Dawson;
        /**
         * The image retrieved from Assets
         */
        private var bg:Image;
        private var rc:RileyCable;
		private var jakeLookingOut:Image;

        /**
         * Main Constructor of BackgroundCompound
         * @param params object - pass in properties
         */
        public function BackgroundCompound(position:uint = 1)
        {
            super(position);
        }

        /**
         * Compose all the variables before draw
         */
        override protected function composeSetting():void
        {
            drawSetting();
        }

        /**
         * Draw the setting
         */
        override protected function drawSetting():void
        {
            //add main background image
            bg = new Image(CompoundAssets.getTexture(BG_IMAGE_NAME));
            addChild(bg);
            // set position
            setCurrentPosition(_currentPosition);
            //Add all the background props and items
            addProps();
        }

        /**
         *
         * @return MakingTape
         */
        public function getMaskingTape():MaskingTape
        {
            return _maskingTape;
        }

        public function addDawson():void
        {
            // add dawson sitting
            dawson = new Dawson("dawson", false, true);
            dawson.x = 232;
            dawson.y = 490;
            addChildAt(dawson, getChildIndex(_stationary));
        }

        public function cuffDawson():void
        {
            dawson.cuffDawson();
        }

        public function getDawson():Dawson
        {
            return dawson;
        }

        public function removeDawson():void
        {
            removeChild(dawson, true);
        }

        public function addRileyHoldingCable():void
        {
            rc = new RileyCable();
            rc.x = 80;
            rc.y = 410;
            addChild(rc);
        }

        public function getRileyCable():RileyCable
        {
            return rc;
        }
		
		public function removeMaskingTape():void
		{
			removeChild(_maskingTape, true);
		}
		
		public function openDoor():void 
		{
			_door.openDoor();
		}
		
		public function removeBackpackAndMash():void 
		{
			_backpack.removeFromParent(true);
			_incognitiveMask.removeFromParent(true);
		}
		
		public function addJakeLooking():void 
		{
			jakeLookingOut = new Image(CompoundAssets.getAtlas().getTexture("jake-looking-out"));
			jakeLookingOut.x = 26;
			jakeLookingOut.y = 390;
			addChild(jakeLookingOut);
		}
		
		public function removeRileyCable():void 
		{
			rc.getMovieclip().texture.dispose();
			rc.removeFromParent(true);
		}

        /**
         * Add Props
         */
        private function addProps():void
        {
            // corkboard
            _corkboard = new Corkboard('corkboard', true);
            _corkboard.x = 200;
            _corkboard.y = 380;
            addChild(_corkboard);
            // plastic bags
            _plasticBag = new PlasticBag('plastic-bag-1', true);
            _plasticBag.x = 293;
            _plasticBag.y = 570;
            addChild(_plasticBag);
            // cabinet
            _cabinet = new Cabinet('cabinet', true);
            _cabinet.x = 350;
            _cabinet.y = 330;
            addChild(_cabinet);
            // window
            _window = new Window('window', true);
            _window.x = 0;
            _window.y = 298;
            addChild(_window);
            // chair
            _chair = new Chair('chair', true);
            _chair.x = 618;
            _chair.y = 446;
            addChild(_chair);
            // mirror
            _mirror = new Mirror('mirror', true);
            _mirror.x = 672;
            _mirror.y = 276;
            addChild(_mirror);
            // sofa
            _sofa = new Sofa('sofa', true);
            _sofa.x = 0;
            _sofa.y = 495;
            addChild(_sofa);
            // incognitive mask
            _incognitiveMask = new IncognitiveMask('incognito-mask', true);
            _incognitiveMask.x = 101;
            _incognitiveMask.y = 632;
            addChild(_incognitiveMask);
            // backpack
            _backpack = new Backpack('backpack', true);
            _backpack.x = 217;
            _backpack.y = 588;
            addChild(_backpack);
            // stationary
            _stationary = new Stationary('stationary', true);
            _stationary.x = 760;
            _stationary.y = 463;
            addChild(_stationary);
			// door
            _door = new Door('door', true);
            _door.x = 878;
            _door.y = 337;
            addChild(_door);
            // masking tape
            _maskingTape = new MaskingTape("masking-tape", true);
            _maskingTape.x = 500;
            _maskingTape.y = 588;
            addChild(_maskingTape);
        }
    }
}