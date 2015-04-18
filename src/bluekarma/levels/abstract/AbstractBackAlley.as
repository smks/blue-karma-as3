package levels.abstract
{
    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.helpers.transitions.Fader;
    import bluekarma.interactive.base.InteractionObject;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import com.greensock.easing.Circ;
    import com.greensock.easing.Quart;
    import com.greensock.TweenLite;

    import global.Global;

    import gui.inventory.phonemenu.ActParams;

    import navigation.PositionArrow;

    import particles.RainParticle;

    import players.riley.Riley;

    import settings.backgrounds.BackgroundBackAlley;
    import settings.foregrounds.ForegroundBackAlley;
    import settings.foregrounds.Overlay;

    import starling.display.Quad;
    import starling.events.Event;

    import states.GameState;

    /**
     * ...
     * @author @shaun
     */
    public class AbstractBackAlley extends AbstractLevel
    {
        protected const TIME_TO_SPAN_BG:Number = 10;
        //Navigation Arrows
        protected var _arrow1:PositionArrow;
        protected var _arrow2:PositionArrow;
        //this is the rain effect seen in the game
        protected var _rain:RainParticle;
        protected var _bg:BackgroundBackAlley;
        protected var _fg:ForegroundBackAlley;
        protected var _fader:Fader;
        protected var _clock:Date = new Date(2013, 0, 0, 20, 15, 0);
        protected var timerCountdownToBeLate:Timer;

        override protected function drawLevel():void
        {
            addBackground();
            addPlayer();
            addForeground();
            addRain();
            addNavigationArrows(30);
            addListeners();
            addInventory();
			addFader();
        }

        override protected function addBackground():void
        {
            _bg = new BackgroundBackAlley();
            _bg.setCurrentPosition(BackgroundBackAlley.POSITION_2);
            addChild(_bg);
        }

        override protected function addPlayer():void
        {
            _player = new Riley();
            _player.setSize(1.3);
            _player.x = 436;
            _player.y = 948;
            addChild(_player);
        }

        override protected function addForeground():void
        {
            _fg = new ForegroundBackAlley(BackgroundBackAlley.POSITION_2);
            _fg.touchable = false;
            addChild(_fg);
        }

        /**
         * set the walking boundaries for the player
         */
        override protected function setWalkingBoundaries(debug:Boolean = false):void
        {
            switch (_backgroundPosition) {
                case 1:
                    _walkBoundaryUp = 0;
                    _walkBoundaryDown = 0;
                    _walkBoundaryLeft = 0;
                    _walkBoundaryRight = 0;
                    break;
                case 2:
                    _walkBoundaryDown = 650;
                    _walkBoundaryUp = 400;
                    _walkBoundaryLeft = 0;
                    _walkBoundaryRight = 1024;
                    break;
            }
            if (debug && _backgroundPosition !== 1) {
                var rec:Quad = new Quad(_walkBoundaryRight, _walkBoundaryDown - _walkBoundaryUp, 0xeeeeee);
                rec.touchable = false;
                rec.x = _walkBoundaryLeft;
                rec.y = _walkBoundaryUp;
                rec.alpha = 0.5;
                addChild(rec);
            }
        }

        override protected function createNavigationArrows():void
        {
            _arrow1 = new PositionArrow("arrow1", true);
            _arrow1.setRotation(_arrow1.DIRECTION_UP);
            _arrow2 = new PositionArrow("arrow2", true);
            _arrow2.setRotation(_arrow2.DIRECTION_DOWN);
            // position arrows according to location of Ladder
            moveLadder(Global.LEFT, false);
        }

        override protected function addNavigationArrows(indexVal:uint = 0):void
        {
            super.addNavigationArrows(indexVal);
            if (indexVal === 0) {
                indexVal = _bg.numChildren;
            }
            //instantiate and place navigation arrows
            createNavigationArrows();
            _arrow1.setSourceDestination(1, 2);
            _arrow2.setSourceDestination(2, 1);
            positionArrowList = new Array();
            //add to stage
            positionArrowList.push(_arrow1);
            positionArrowList.push(_arrow2);
            var len:uint = positionArrowList.length;
            for (var i:uint = 0; i < len; i++) {
                _bg.addChild(positionArrowList[i]);
                _bg.setChildIndex(positionArrowList[i], indexVal);
            }
            showCorrectArrows(_backgroundPosition);
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

        /**
         * Back alley can only span up and down with a tween or not
         *
         * @param    position
         * @param    tween
         */
        public function setCurrentPosition(position:uint, tween:Number = 0, movePlayer:Boolean = true):void
        {
            //_arrow1.touchable = false;
            //_arrow2.touchable = false;
            //assign new position
            _backgroundPosition = position;
            // the y position we are changing
            var yToBe:Number;
            var playerYToBe:Number;
            //set position of background
            switch (_backgroundPosition) {
                case 1 :
                    yToBe = 0;
                    playerYToBe = 948;
                    break;
                case 2 :
                    yToBe = -Game.STAGE_HEIGHT;
                    playerYToBe = 948 - Game.STAGE_HEIGHT;
                    break;
                default :
                    throw new Error('The position provided was not valid');
            }
            if (tween > 0) {
                _fg.tweenPosition(yToBe, 4.25);
                TweenLite.to(_bg, 4, {
                    y: yToBe,
                    ease: Quart.easeInOut
                });
                if (movePlayer) {
                    TweenLite.to(_player, 4, {
                        y: playerYToBe,
                        ease: Quart.easeInOut
                    });
                }
            } else {
                _fg.tweenPosition(yToBe);
                TweenLite.to(_bg, 0, {
                    y: yToBe
                });
                if (movePlayer) {
                    _player.y = playerYToBe;
                }
            }
            setWalkingBoundaries();
        }

        /**
         *
         * @param direction = Global.LEFT
         */
        public function moveLadder(direction:String = Global.LEFT, playSound:Boolean = true):void
        {
            if (playSound) {
                SoundAssets.ladderLayDown.play();
            }
            // set ladder in correct direction
            _bg.getLadder().changeDirection(direction);
            // physically move the ladder
            _bg.moveLadderToWallOn(direction);
            if (direction === Global.RIGHT) {
                _arrow1.x = 974;
                _arrow1.y = 920;
                _arrow2.x = 974;
                _arrow2.y = 700;
                return;
            }
            // otherwise set to the left
            _arrow1.x = 50;
            _arrow1.y = 920;
            _arrow2.x = 50;
            _arrow2.y = 700;
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
         * @desc Arrows have to be hidden in different areas of level
         * @param    backgroundPosition
         */
        protected function showCorrectArrows(bgPos:uint):void
        {
            trace("current bg position being applied is now: ", bgPos);
            switch (bgPos) {
                case 1:
                    _arrow1.visible = true;
                    _arrow2.visible = false;
                    break;
                case 2:

                    //hide buttons when beginning
                    _arrow1.visible = false;
                    _arrow2.visible = true;
                    break;
                default:
                    throw new Error("not found position");
            }
        }

        /**
         *
         * @param arrowTarget
         * @param fader
         */
        protected function handlePositionArrow(arrowTarget:PositionArrow, fader:Fader, fade:Boolean = false):void
        {
            //makes sure player is standing before he can change bg position
            if (_player.getPlayerState() === _player.PLAYER_STANDING_STATE) {
                if (arrowTarget.getDestination() >= 1 && arrowTarget.getDestination() <= 2) {
                    showCorrectArrows(arrowTarget.getDestination());
                    if (fade) {
                        setChildIndex(fader, this.numChildren);
                        fader.fadeIn(0, 0);
                        fader.fadeOut(3, 3);
                    }
                    setCurrentPosition(arrowTarget.getSource(), (fade) ? 0 : TIME_TO_SPAN_BG, true);
                    setWalkingBoundaries();
                } else {
                    throw new Error("destination wrong");
                }
            }
        }

        /**
         * Add phone menu with params
         */
        protected function setMobileProperties():void
        {
            //add phone menu and params
            var actParams:ActParams = new ActParams();
            // this will fetch necessary params for this act (1)
            var params:Object = actParams.getLevelOneActFourParams();
            // pass these params into phone menu to enable it
            _inventory.addMobileDashboard(params);
            timerCountdownToBeLate = new Timer(1000);
            timerCountdownToBeLate.addEventListener(TimerEvent.TIMER, checkTimeNotLate);
            timerCountdownToBeLate.start();
			addContacts();
            _inventory.addReminder("way_in_compound", "find a way into the compound", "critical");
        }

        protected function prematurelyFinishAct():void
        {
        }

        private function checkTimeNotLate(e:TimerEvent):void
        {
            var currentTime:Date = _inventory.getCurrentTimeOnAct();
            var deadlineTime:Date = _inventory.getActTimeDeadline();
            if (Global.stillHasTimeToContinue(currentTime, deadlineTime)) {
                return;
            }
            prematurelyFinishAct();
        }

        /**
         * Add rain effect
         */
        private function addRain():void
        {
            _rain = new RainParticle();
            addChild(_rain);
        }
		
		/**
		 * 
		 * @return bool
		 */
		public function hasTakenKeyAndCrowbar():Boolean
		{
			//return (_inventory.getItem("crowbar") && _inventory.getItem("fan-keys")) ? true : false;
			return (_bg.getCrowbar().takenFromToolBox() === true && _bg.getFanKeys().takenFromToolBox() === true) ? true : false;
		}
		
		private function addContacts():void 
		{
			_inventory.addContact('tyrone', 'Tyrone Marshall', false);
			_inventory.addContact('albert', 'Albert Green', false);
		}
		
		public function getBackground():BackgroundBackAlley 
		{
			return _bg;
		}
    }
}