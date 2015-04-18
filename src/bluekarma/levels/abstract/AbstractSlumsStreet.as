package bluekarma.levels.abstract
{
    import assets.Level1Assets;

    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.helpers.transitions.Fader;
    import bluekarma.interactive.base.InteractionObject;
    import bluekarma.interactive.base.Item;

    import dialogue.phone.components.PhoneButton;

    import gui.inventory.Inventory;

    import levels.abstract.AbstractLevel;

    import navigation.PositionArrow;

    import particles.RainParticle;

    import players.AbstractPlayer;
    import players.riley.Riley;

    import settings.backgrounds.BackgroundSlumsStreet;
    import settings.foregrounds.slums_street.ForegroundSlumsStreet;
    import settings.foregrounds.Overlay;

    import starling.display.Image;
    import starling.display.Quad;
    import starling.events.Event;

    import states.GameState;

    /**
     *
     * @author shaun michael stone
     *
     */
    public class AbstractSlumsStreet extends AbstractLevel
    {
        /**
         * Attributes
         */
        //this is the rain effect seen in the game
        protected var _rain:RainParticle;
        //this is the street background (spans 3 screens)
        protected var _bgStreet:BackgroundSlumsStreet;
        //foreground
        protected var _fgStreet:ForegroundSlumsStreet;
        //Navigation Arrows
        protected var _arrow2:PositionArrow;
        protected var _arrow3:PositionArrow;
        protected var _arrow4:PositionArrow;
        protected var _arrow5:PositionArrow;
        protected var _arrow6:PositionArrow;
        /**
         * Level 1 Attributes
         */

        protected var _clock:Date = new Date(2013, 0, 0, 20, 15, 0);
        /*
         *
         * Methods
         *
         */
        override protected function drawLevel():void
        {
            addBackground();
            addPlayer();
            addForeground();
            addRain();
            addNavigationArrows();
            addListeners();
            addGradientOverlay();
            addInventory();
        }

        override protected function addBackground():void
        {
            //add the background to stage
            _bgStreet = new BackgroundSlumsStreet();
            addChild(_bgStreet);
        }

        override protected function addPlayer():void
        {
            _player = new Riley();
            // hide player by default
            _player.x = -200;
            _player.y = 260;
            addChild(_player);
        }

        override protected function addForeground():void
        {
            _fgStreet = new ForegroundSlumsStreet();
            //_fgStreet.turnOffLights();
            _fgStreet.touchable = false;
            addChild(_fgStreet);
        }

        override protected function createNavigationArrows():void
        {
            _arrow2 = new PositionArrow("arrow2", true);
            _arrow2.setRotation(_arrow2.DIRECTION_RIGHT);
            _arrow2.scaleX = 0.5;
            _arrow2.x = 965;
            _arrow2.y = 550;
            _arrow3 = new PositionArrow("arrow3", true);
            _arrow3.setRotation(_arrow3.DIRECTION_LEFT);
            _arrow3.scaleX = 0.5;
            _arrow3.x = 930;
            _arrow3.y = 550;
            _arrow4 = new PositionArrow("arrow4", true);
            _arrow4.setRotation(_arrow4.DIRECTION_RIGHT);
            _arrow4.scaleX = 0.5;
            _arrow4.x = 1782;
            _arrow4.y = 550;
            _arrow5 = new PositionArrow("arrow5", true);
            _arrow5.setRotation(_arrow5.DIRECTION_LEFT);
            _arrow5.scaleX = 0.5;
            _arrow5.x = 1623;
            _arrow5.y = 550;
            _arrow6 = new PositionArrow("arrow6", true);
            _arrow6.setRotation(_arrow5.DIRECTION_RIGHT);
            _arrow6.x = 930;
            _arrow6.y = 937;
        }

        override protected function addNavigationArrows(indexVal:uint = 0):void
        {
            super.addNavigationArrows(indexVal);
            if (indexVal == 0) {
                indexVal = _bgStreet.numChildren;
            }
            //instantiate and place navigation arrows
            createNavigationArrows();
            _arrow2.setSourceDestination(1, 2);
            _arrow3.setSourceDestination(2, 1);
            _arrow4.setSourceDestination(2, 3);
            _arrow5.setSourceDestination(3, 2);
            _arrow6.setSourceDestination(0, 1);
            // where does the player appear once clicked on an arrow
            _arrow2.setPlayerTargetDestinationPoint(30, 260);
            _arrow3.setPlayerTargetDestinationPoint(990, 260);
            _arrow4.setPlayerTargetDestinationPoint(30, 260);
            _arrow5.setPlayerTargetDestinationPoint(990, 260);
            _arrow6.setPlayerTargetDestinationPoint(300, 260);
            positionArrowList = new Array();
            //add to stage
            positionArrowList.push(_arrow2);
            positionArrowList.push(_arrow3);
            positionArrowList.push(_arrow4);
            positionArrowList.push(_arrow5);
            positionArrowList.push(_arrow6);
            var len:uint = positionArrowList.length;
            for (var i:uint = 0; i < len; i++) {
                _bgStreet.addChild(positionArrowList[i]);
                _bgStreet.setChildIndex(positionArrowList[i], indexVal);
            }
            showCorrectArrows(_backgroundPosition);
        }

        /**
         * set the walking boundaries for the player
         */

        override protected function setWalkingBoundaries(debug:Boolean = false):void
        {
            switch (_backgroundPosition) {
                case 0:
                    _walkBoundaryUp = 685;
                    _walkBoundaryDown = 768;
                    _walkBoundaryLeft = 0;
                    _walkBoundaryRight = 700;
                    break;
                case 1:
                    _walkBoundaryUp = 495;
                    _walkBoundaryDown = 590;
                    _walkBoundaryLeft = 0;
                    _walkBoundaryRight = 1024;
                    break;
                case 2:
                    _walkBoundaryUp = 495;
                    _walkBoundaryDown = 590;
                    _walkBoundaryLeft = 0;
                    _walkBoundaryRight = 1024;
                    break;
                case 3:
                    _walkBoundaryUp = 495;
                    _walkBoundaryDown = 590;
                    _walkBoundaryLeft = 0;
                    _walkBoundaryRight = 1024;
                    break;
            }
            if (debug) {
                var rec:Quad = new Quad(_walkBoundaryRight, _walkBoundaryDown - _walkBoundaryUp, 0xeeeeee);
                rec.x = _walkBoundaryLeft;
                rec.y = _walkBoundaryUp;
                rec.alpha = 0.5;
                addChild(rec);
            }
            trace("walk boundaries are:", _walkBoundaryUp, _walkBoundaryDown, _walkBoundaryLeft, _walkBoundaryRight);
        }

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

        override protected function proceedWithDecision(e:Event):void
        {
            removeEventListener("DecisionMade", proceedWithDecision);
            var decision:String = _decisionWheel.getCurrentAction()
            var objectId:String = _decisionWheel.getCurrentObjectId();
            var interactionObject:InteractionObject = _decisionWheel.getCurrentInteractionObject();
            var object:Object = new Object();
            object.level = this;
            switch (decision) {
                case DecisionWheel.ACTION :
                    //main method to action on all interaction objects
                    interactionObject.triggerInteractionObject(object);
                case DecisionWheel.CHAT :
                    interactionObject.triggerChat();
                    break;
                case DecisionWheel.EXAMINE :
                    interactionObject.triggerExamine();
                    break;
            }
            _decisionWheel.removeDecisionWheel();
            _overlay.removeOverlay();
            //reset
            GameState.AWAITING_DECISION = false;
            userInteraction(true);
        }

        protected function setBackgroundAndForeground(position:uint):void
        {
            _backgroundPosition = position;
            _bgStreet.setCurrentPosition(position);
            _fgStreet.setCurrentPosition(position);
        }

        /**
         * @desc Arrows have to be hidden in different areas of level
         * @param    backgroundPosition
         */
        protected function showCorrectArrows(bgPos:uint):void
        {
            trace("current bg position being applied is now: ", bgPos);
            switch (bgPos) {
                case 0:
                    break;
                case 1:

                    //hide buttons when beginning
                    _arrow2.visible = true;
                    _arrow3.visible = false;
                    _arrow4.visible = false;
                    _arrow5.visible = false;
                    _arrow6.visible = true;
                    break;
                case 2:

                    //hide buttons when beginning
                    _arrow2.visible = false;
                    _arrow3.visible = true;
                    _arrow4.visible = true;
                    _arrow5.visible = false;
                    _arrow6.visible = false;
                    break;
                case 3:

                    //hide buttons when beginning
                    _arrow2.visible = false;
                    _arrow3.visible = false;
                    _arrow4.visible = false;
                    _arrow5.visible = true;
                    _arrow6.visible = false;
                    break;
            }
        }

        protected function handlePositionArrow(arrowTarget:PositionArrow, fader:Fader):void
        {
            trace("arrow has id of", arrowTarget.getId());
            trace("players is currently", _player.getPlayerState());
            //makes sure player is standing before he can change bg position
            if (_player.getPlayerState() === _player.PLAYER_STANDING_STATE) {
                trace("arrow source is: ", arrowTarget.getSource());
                trace("arrow destination is: ", arrowTarget.getDestination());
                if (arrowTarget.getDestination() >= 0) {
                    setChildIndex(fader, this.numChildren);
                    fader.fadeIn(0, 0);
                    fader.fadeOut(2, 1);
                    // hide arrows
                    showCorrectArrows(arrowTarget.getDestination());
                    if (arrowTarget.getDestination() === 0) {
                        _player.setSize(1.5);
                    } else {
                        _player.setSize(1);
                    }
                    setBackgroundAndForeground(arrowTarget.getDestination());
                    _player.movePlayerPosition(arrowTarget.getTargetXPoint(), arrowTarget.getTargetYPoint(), arrowTarget.getDirection());
                    setWalkingBoundaries();
                }
            }
        }

        /**
         * Add rain effect
         */
        private function addRain():void
        {
            _rain = new RainParticle();
            addChild(_rain);
        }

        private function addListeners():void
        {
        }
    }
}