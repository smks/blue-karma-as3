package levels.base
{
    //starling framework classes
    import bluekarma.components.decisions.DecisionWheel;

    import gui.inventory.Inventory;

    import navigation.PositionArrow;

    import players.riley.Riley;

    import bluekarma.levels.abstract.AbstractRileysApartment;

    import settings.foregrounds.Overlay;

    import helpers.GameClock;

    import bluekarma.interactive.base.InteractionObject;

    import players.AbstractPlayer;

    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    import starling.display.Quad;

    import states.GameState;

    import interactive.apartment.repos.ApartmentInteractionRepo;

    //events
    import events.InteractionEvent;

    /**
     * ...
     * @author Shaun Stone
     */
    public class RileysApartment extends AbstractRileysApartment
    {
        public function RileysApartment(timeOfDay:String = "night")
        {
            _timeOfDay = timeOfDay;
            this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         * initialise level
         */

        override protected function initializeLevel():void
        {

            //set walking boundaries for current level
            setWalkingBoundaries();
            //add listener for any objects touched
            _apartmentBg.addEventListener(InteractionEvent.INTERACT, interactionHandler);
        }

        /**
         * @desc This handles any touch event interactions in the level
         * @param    event
         */

        override protected function touchInteractionHandler(event:TouchEvent):void
        {

            //register event listeners for touches
            var touchBegan:Touch = event.getTouch(this, TouchPhase.BEGAN);
            var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
            var touchHover:Touch = event.getTouch(this, TouchPhase.HOVER);
            var playerShouldntMove:Boolean = event.target is Button;
            var arrowTarget:PositionArrow;
            if (event.target is Button) {
                return;
            }
            if (touchHover) {
                if (event.target is PositionArrow) {
                    arrowTarget = event.target as PositionArrow;
                    arrowTarget.alpha = 1;
                }
            }
            //listen for touches that have just ended
            if (touchEnded) {
                if (event.target is Image) {
                    trace(event.target);
                    //check for navigation first
                    if (Image(event.target).parent.parent.parent is Inventory) {
                        return;
                    }
                }
                //check for navigation first
                if (event.target is PositionArrow) {
                    arrowTarget = event.target as PositionArrow;
                    //makes sure player is standing before he can change bg position
                    if (_player.getPlayerState() === _player.PLAYER_STANDING_STATE) {
                        if (arrowTarget.getDestination()) {
                            arrowTarget.alpha = 0.5;
                            this.setBackgroundAndForeground(arrowTarget.getDestination());
                            _player.movePlayerPosition(arrowTarget.getTargetXPoint(), arrowTarget.getTargetYPoint(), arrowTarget.getDirection());
                            setWalkingBoundaries();
                        }
                    }
                    return;
                }
                //otherwise interaction with
                if (event.target is InteractionObject) {

                    /*
                     trace(DisplayObject(event.target) as InteractionObject);
                     trace(DisplayObject(event.target).parent as InteractionObject);
                     trace(DisplayObject(event.target).parent.parent as InteractionObject);
                     trace(DisplayObject(event.target).parent.parent.parent as InteractionObject);
                     trace(DisplayObject(event.target).parent.parent.parent.parent as InteractionObject);
                     */
                    //get target as an object
                    var obj:InteractionObject = InteractionObject(event.target) as InteractionObject;
                    dispatchEvent(new InteractionEvent(InteractionEvent.INTERACT, {
                        _id: obj._id,
                        _type: obj._type,
                        _object: obj,
                        _x: touchEnded.globalX,
                        _y: touchEnded.globalY
                    }, true));
                    return;
                }
                if (_player !== null && !playerShouldntMove && touchEnded.tapCount === 1) {
                    if (_player.getPlayerState() === _player.PLAYER_STANDING_STATE) {
                        //check if player is in walking range
                        _player.playerWalkCheck(touchEnded.globalX, touchEnded.globalY, _backgroundPosition, _walkBoundaryUp, _walkBoundaryDown, _walkBoundaryLeft, _walkBoundaryRight);
                    }
                    return;
                }
            }
        }

        /**
         *
         * @param    event
         */

        override protected function interactionHandler(event:InteractionEvent):void
        {
            trace("interaction handler called");
            //stop player from interacting
            userInteraction(false);
            this.addEventListener("InteractionComplete", onInteractionComplete);
            //get object properties
            var interactObject:Object = event.params;
            //make player look in direction of target
            _player.setDirectionToTarget(_player.x, interactObject._x, _apartmentBg.getCurrentPosition());
            //call method to create decision wheel
            createDecisionWheel(interactObject);
        }

        /*
         *
         * Interaction Section - This is where all the interaction of characters, items and props triggers
         *
         */
        override protected function onInteractionComplete(e:Event):void
        {
            trace("interaction HAS COMPLETED");
            userInteraction(true);
        }

        /**
         *
         * @param    object
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

        override protected function proceedWithDecision(e:Event):void
        {
            removeEventListener("DecisionMade", proceedWithDecision);
            var decision:String = _decisionWheel.getCurrentAction()
            var objectId:String = _decisionWheel.getCurrentObjectId();
            var interactionObject:InteractionObject = _decisionWheel.getCurrentInteractionObject();
            switch (decision) {
                case DecisionWheel.ACTION :
                    //main method to action on all interaction objects
                    interactionObject.triggerInteractionObject();
                    break;
                case DecisionWheel.CHAT :
                    interactionObject.triggerChat();
                    break;
                case DecisionWheel.EXAMINE :
                    interactionObject.triggerExamine();
                    break;
            }
            //remove once decision has been made
            _decisionWheel.removeDecisionWheel();
            _overlay.removeOverlay();
            //reset
            GameState.AWAITING_DECISION = false;
            userInteraction(true);
        }

        public function addPlayerTest():void
        {
            _player = new Riley(12);
            _player.x = 300;
            _player.y = 370
            _player.scaleX = 1.2;
            _player.scaleY = 1.2;
            addChildAt(_player, getChildIndex(_apartmentFg));
        }

        /**
         * @desc called when the class object is added to the stage
         * @param event
         */

        private function onAdded(e:Event):void
        {
            //remove the listener
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            //set up the game
            drawLevel();
            //initialise level
            initializeLevel();
            //allow interaction with level
            userInteraction(true);
        }
    }
}