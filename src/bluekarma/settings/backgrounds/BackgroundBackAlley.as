package settings.backgrounds
{
    import assets.BackAlleyAssets;

    import bluekarma.assets.sound.SoundAssets;

    import global.Global;

    import interactive.backalley.items.Cable;
    import interactive.backalley.items.Crowbar;
    import interactive.backalley.items.FanKeys;
    import interactive.backalley.items.ToolboxKey;
    import interactive.backalley.props.Bricks;
    import interactive.backalley.props.FanPanel;
    import interactive.backalley.props.MetalFenceBig;
    import interactive.backalley.props.MetalFrame;
    import interactive.backalley.props.Roof;
    import interactive.backalley.props.Cables;

    import com.greensock.TweenLite;

    import interactive.backalley.props.Fan;
    import interactive.backalley.props.Ladder;
    import interactive.backalley.props.Rubbish;
    import interactive.backalley.props.Toolbox;
    import interactive.backalley.props.TrashCan;
    import interactive.backalley.props.Window;
    import interactive.slumsstreet.props.MetalFenceDoor;

    import players.riley.RileyOnLadder;

    import settings.AbstractSetting;

    import starling.display.Image;

    /**
     * ...
     * @author @shaun
     */
    public class BackgroundBackAlley extends AbstractSetting
    {
        public static const POSITION_1:Number = 1;
        public static const POSITION_2:Number = 2;
        public const BG_IMAGE_NAME:String = 'BackAlleyBackgroundImage';
        private var _bg:Image;
        private var _fan:Fan;
        private var _ladder:Ladder;
        private var _cable:Cable;
        private var _cables:Cables;
        private var _roof1:Roof;
        private var _roof2:Roof;
        private var _frame1:MetalFrame;
        private var _frame2:MetalFrame;
        private var _window:Window;
        private var _highMetalFence:MetalFenceBig;
        private var _metalFenceDoor:MetalFenceDoor;
        private var _rileyLadder:RileyOnLadder;
        private var _fanPanel:FanPanel;
        private var _toolbox:Toolbox;
        private var _rubbish:Rubbish;
        private var _trashCan:TrashCan;
        private var _bricks:Bricks;
        private var _toolboxKey:ToolboxKey;
        private var _fanKeys:FanKeys;
        private var _crowbar:Crowbar;

        public function BackgroundBackAlley(position:uint = 1)
        {
            super(position);
        }

        override protected function composeSetting():void
        {
            drawSetting();
        }

        override protected function drawSetting():void
        {
            //add _bgStreet
            _bg = new Image(BackAlleyAssets.getTexture(BG_IMAGE_NAME));
            addChild(_bg);
            // set position
            setCurrentPosition(_currentPosition);
            //Add all the background props
            addProps();
            addItems();
        }

        /**
         *
         * @param pos
         */
        override public function setCurrentPosition(position:uint):void
        {
            //assign new position
            _currentPosition = position;
        }

        /**
         *
         * @return RileyOnLadder
         */
        public function getRileyLadder():RileyOnLadder
        {
            return _rileyLadder;
        }

        /**
         *
         * @param direction
         * @param makeVisible
         */
        public function moveRileysPlaceOnLadder(direction:String, makeVisible:Boolean = false):void
        {
            if (direction === Global.LEFT) {
                _rileyLadder.x = 160;
                _rileyLadder.y = 500;
            } else if (direction === Global.RIGHT) {
                _rileyLadder.x = 800;
                _rileyLadder.y = 598;
            } else {
                throw new EvalError("Should be left or right");
            }
            _rileyLadder.changeDirection(direction);
            if (makeVisible) {
                _rileyLadder.show();
            } else {
                _rileyLadder.hide();
            }
        }

        /**
         *
         * @param direction
         */
        public function moveLadderToWallOn(direction:String):void
        {
            if (direction === Global.LEFT) {
                _ladder.x = 130;
                _ladder.y = 800;
            } else if (direction === Global.RIGHT) {
                _ladder.x = 820;
                _ladder.y = 805;
            } else {
                throw new EvalError("Should be left or right");
            }
            _ladder.changeDirection(direction);
        }

        /**
         *
         * @return
         */
        public function getLadder():Ladder
        {
            return _ladder;
        }

        public function getToolBoxKey():ToolboxKey
        {
            return this._toolboxKey;
        }

        public function getToolBox():Toolbox
        {
            return this._toolbox;
        }

        public function removeToolBoxKey():void
        {
            this._toolboxKey = null;
        }

        public function getCrowbar():Crowbar
        {
            return _crowbar;
        }

        public function getFanKeys():FanKeys
        {
            return _fanKeys;
        }

        public function showToolboxItems():void
        {
            setChildIndex(_toolbox, getChildIndex(_fanKeys));
        }

        public function testToolBoxItemPlacements():void
        {
            if (BlueKarma.ENVIRONMENT !== BlueKarma.TESTING) {
                return;
            }
            _toolbox.open();
            this.y = -Game.STAGE_HEIGHT;
            _toolbox.alpha = 0.5;
        }

        public function openFanPanel():void
        {
            SoundAssets.unlockCompartment.play();
            _fanPanel.unlock();
        }

        public function getFanPanel():FanPanel
        {
            return _fanPanel;
        }

        public function getFan():Fan
        {
            return _fan;
        }

        public function getWindow():Window
        {
            return _window;
        }

        public function getRileyOnLadderDirection():String
        {
            return _rileyLadder.getCurrentDir();
        }

        private function addItems():void
        {
        }

        private function addProps():void
        {
            _highMetalFence = new MetalFenceBig("metal-fence-big", false);
            _highMetalFence.x = 329;
            _highMetalFence.y = 427;
            addChild(_highMetalFence);
            _metalFenceDoor = new MetalFenceDoor("metal_fence_door", true);
            _metalFenceDoor.x = 344;
            _metalFenceDoor.y = 830;
            _metalFenceDoor.setLevelItem(MetalFenceDoor.BACK_ALLEY);
            addChild(_metalFenceDoor);
            _rubbish = new Rubbish("rubbish", true);
            _rubbish.x = 508;
            _rubbish.y = 1053;
            addChild(_rubbish);
            _trashCan = new TrashCan("trash-can", false);
            _trashCan.x = 656;
            _trashCan.y = 1002;
            addChild(_trashCan);
            _toolboxKey = new ToolboxKey("toolbox-key", true);
            _toolboxKey.x = 725;
            _toolboxKey.y = 1187;
            addChild(_toolboxKey);
            _bricks = new Bricks("bricks", true);
            _bricks.x = 696;
            _bricks.y = 1148;
            addChild(_bricks);
            _frame2 = new MetalFrame("frame-2", false);
            _frame2.scaleX = 0.9;
            _frame2.scaleY = 0.9;
            _frame2.x = 250;
            _frame2.y = 66;
            addChild(_frame2);
            _fan = new Fan("fan", false);
            _fan.x = 190;
            _fan.y = 190;
            addChild(_fan);
            _fanPanel = new FanPanel("fan-panel", false);
            _fanPanel.x = 200;
            _fanPanel.y = 290;
            addChild(_fanPanel);
            _ladder = new Ladder("ladder", false);
            _ladder.x = 130;
            _ladder.y = 800;
            addChild(_ladder);
            _rileyLadder = new RileyOnLadder('riley_ladder', false);
            _rileyLadder.scaleX = 1.25;
            _rileyLadder.scaleY = 1.25;
            _rileyLadder.x = 166;
            _rileyLadder.y = 490;
            addChild(_rileyLadder);
            _rileyLadder.hide();
            _frame1 = new MetalFrame("frame-1", false);
            _frame1.touchable = false;
            _frame1.scaleX = 1.1;
            _frame1.scaleY = 1.1;
            _frame1.y = 25;
            addChild(_frame1);
            _cable = new Cable("cable", true);
            _cable.x = 22;
            _cable.y = 175;
            addChild(_cable);
            _fanKeys = new FanKeys("fan-keys", true);
            _fanKeys.x = 310;
            _fanKeys.y = 1135;
            addChild(_fanKeys);
            _crowbar = new Crowbar("crowbar", true);
            _crowbar.x = 265;
            _crowbar.y = 1140;
            addChild(_crowbar);
            _toolbox = new Toolbox("toolbox", true);
            _toolbox.x = 200;
            _toolbox.y = 1080;
            addChild(_toolbox);
            _roof1 = new Roof("roof-left");
            addChild(_roof1);
            _window = new Window("window");
            _window.x = 611;
            _window.y = 13;
            addChild(_window);
            _roof2 = new Roof("roof-right");
            _roof2.x = 620;
            addChild(_roof2);
            _cables = new Cables("cables", true);
			_cables.scaleX = 2;
			_cables.scaleY = 2;
            addChild(_cables);
        }
    }
}