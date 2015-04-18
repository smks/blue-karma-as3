package levels.abstract
{
    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.helpers.transitions.Fader;
    import bluekarma.interactive.general.items.DigiCuffs;
    import bluekarma.settings.backgrounds.BackgroundCompound;
    import bluekarma.settings.foregrounds.ForegroundCompound;

    import interactive.backalley.items.Cable;

    import gui.inventory.phonemenu.ActParams;

    import navigation.PositionArrow;

    import players.AbstractPlayer;

    import starling.display.Quad;

    import states.GameState;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.helpers.transitions.Fader;
    import bluekarma.interactive.base.InteractionObject;

    import global.Global;

    import players.riley.Riley;

    import settings.foregrounds.Overlay;

    import starling.events.Event;

    /**
     * ...
     * @author @shaun
     */
    public class AbstractCompound extends AbstractLevel
    {
        //Navigation Arrows
        protected var _arrow1:PositionArrow;
        protected var _arrow2:PositionArrow;
        //this is the rain effect seen in the game
        protected var _bg:BackgroundCompound;
        protected var _fg:ForegroundCompound;
        protected var _fader:Fader;

        override protected function drawLevel():void
        {
            addBackground();
            addPlayer();
            addForeground();
            addNavigationArrows(30);
            addListeners();
            addInventory();
            addFader();
            setWalkingBoundaries(false);
        }

        override protected function addBackground():void
        {
            _bg = new BackgroundCompound();
            _bg.setCurrentPosition(BackgroundCompound.POSITION_1);
            addChild(_bg);
        }

        /**
         * Add Inventory to Level
         *
         * @param addChip
         */
        override protected function addInventory(addChip:Boolean = false, debug:Boolean = false):void
        {
            super.addInventory(addChip, debug);
            if (BlueKarma.ENVIRONMENT === BlueKarma.TESTING) {
                if (_inventory.getItem('cable') === null) {
					var ca:Cable = new Cable('cable', true);
                    addChild(ca)
                    _inventory.addItem(ca);
                }
				
				if (_inventory.getItem(DigiCuffs.getId()) === null) {
					var dc:DigiCuffs = new DigiCuffs(DigiCuffs.getId(), true);
					addChild(dc);
					_inventory.addItem(dc);
                }	
            }
        }

        override protected function addPlayer():void
        {
            _player = new Riley();
            _player.x = 278;
            _player.y = 410;
            addChild(_player);
            _player.stand(AbstractPlayer.DIRECTION_RIGHT);
        }

        override protected function addForeground():void
        {
            _fg = new ForegroundCompound(ForegroundCompound.POSITION_1);
            _fg.touchable = false;
            addChild(_fg);
        }

        /**
         * set the walking boundaries for the player
         */
        override protected function setWalkingBoundaries(debug:Boolean = false):void
        {
            _walkBoundaryUp = 627;
            _walkBoundaryDown = 753;
            _walkBoundaryLeft = 345;
            _walkBoundaryRight = 920;
            if (debug) {
                var rec:Quad = new Quad(_walkBoundaryRight, _walkBoundaryDown - _walkBoundaryUp, 0xeeeeee);
                rec.touchable = false;
                rec.x = _walkBoundaryLeft;
                rec.y = _walkBoundaryUp;
                rec.alpha = 0.5;
                addChild(rec);
            }
        }

        /**
         *
         * @param object
         */
        override protected function createDecisionWheel(object:Object):void
        {
            userInteraction(false);
            if (!GameState.AWAITING_DECISION) {
                //create bg overlay
                _overlay = new Overlay();
                addChild(_overlay);
                //waiting for decision from user
                GameState.AWAITING_DECISION = true;
                _decisionWheel = new DecisionWheel(object);
                addChild(_decisionWheel);
                _decisionWheel.x = _decisionWheel.positionDecisionWheelX(object._x, _backgroundPosition);
                _decisionWheel.y = _decisionWheel.positionDecisionWheelY(object._y, _backgroundPosition);
                addEventListener("DecisionMade", proceedWithDecision);
            }
        }

        protected function addListeners():void
        {
            activateListeners();
        }

        protected function addFader():void
        {
            _fader = new Fader();
            addChild(_fader);
        }

        /**
         * Add phone menu with params
         */
        protected function setMobileProperties():void
        {
            //add phone menu and params
            var actParams:ActParams = new ActParams();
            // this will fetch necessary params for this act (1)
            var params:Object = actParams.getLevelOneActFiveParams();
            // pass these params into phone menu to enable it
            _inventory.addMobileDashboard(params);
        }
    }
}