package levels.level1.part2
{
    import assets.dialogue.Level1DialogueAssets;
    import assets.InventoryAssets;
    import assets.ItemAssets;
    import assets.PlaqueAssets;
    import assets.settings.backgrounds.albertscar.moving.MovingBackgroundSlumsAssets;
	import notifications.mail.missions.MissionStatementDawson;
	import score.medals.Medals;

    import bluekarma.assets.characters.albertscar.AlbertAssets;
    import bluekarma.assets.settings.backgrounds.albertscar.AlbertJourneyAssets;
    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.helpers.transitions.Fader;
    import bluekarma.interactive.base.InteractionObject;
    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;
    import bluekarma.interactive.general.items.DigiCuffs;
    import bluekarma.interactive.general.items.LockPick;

    import score.Act2Score;

    import com.greensock.TweenLite;

    import components.gestures.hold.Select;

    import dialogue.character.albertscar.AlbertRileyDialogue;
    import dialogue.phone.components.PhoneButton;

    import events.InteractionEvent;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import gui.inventory.Inventory;

    import interactive.albertscar.repos.AlbertsCarInteractionRepo;

    import levels.abstract.AbstractLevel;

    import bluekarma.settings.backgrounds.albertscar.BackgroundAlbertsCar;

    import levels.level1.Level1;

    import messages.Message;

    import settings.foregrounds.ForegroundAlbertsCar;
    import settings.foregrounds.Overlay;

    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.events.Event;
    import starling.events.EventDispatcher;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    import states.GameState;

    /**
     * ...
     * @author Shaun Stone
     */
    public class RileysJourneyAlbert extends AbstractLevel
    {
        private const LEVEL:String = "Level 1";
        private const ACT:String = "Act 2";
        private const TITLE:String = "The Journey";
        //states for part 2 - ALberts journey
        private const _PLAYER_IN_CAR:uint = 1; // start by trying to talk to albert
        private const _PLAYER_SPOKE_TO_DRIVER:uint = 2; // now spoke to driver examine window
        private const _PLAYER_LOOKED_OUT_WINDOW:uint = 3;
        private const _PLAYER_CHECKED_MIDDLE:uint = 4;
        private const _IN_CONVERSATION:uint = 5;
        private const _ARRIVED_AT_SLUMS:uint = 6;
        private const _READY_TO_LEAVE:uint = 7;
        // settings
        private var _carBg:BackgroundAlbertsCar;
        private var _carFg:ForegroundAlbertsCar;
        private var _dialogueAlbertRiley1:AlbertRileyDialogue;
        private var _fader:Fader;
        private var object:Object;
        private var examinedAlbert:Boolean = false;
        private var readMail:Boolean = false;
		private var missionStatementDawson:MissionStatementDawson;

        public function RileysJourneyAlbert(act2Score:Act2Score)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
            setLevelActName(InteractionRepoFactory.ALBERTS_CAR);
            this.actScore = act2Score;
        }

        override protected function initializeLevel():void
        {
            // listen for thoughts
            activateListeners();
            // make interaction false until completed tween zoom
            userInteraction(false);
            //add listener for any objects touched in background
            addEventListener(InteractionEvent.INTERACT, interactionHandler);
            // set current state to 1 (1 by default)
            setCurrentState(_PLAYER_IN_CAR);
            // listen for messages
            activateListeners();
            addInventory();
            _inventory.hide();
            //used to get messages
            _repo = new AlbertsCarInteractionRepo();
        }

        override protected function drawLevel():void
        {
            // draw background
            _carBg = new BackgroundAlbertsCar(1, true);
            _carBg.scaleX = 2;
            _carBg.scaleY = 2;
            _carBg.x = -100;
            _carBg.y = -100;
            addChild(_carBg);
            // draw foreground
            _carFg = new ForegroundAlbertsCar(1);
            _carFg.scaleX = 2.4;
            _carFg.scaleY = 2.4;
            _carFg.x = -100;
            _carFg.y = -100;
            _carFg.touchable = false;
            addChild(_carFg);
            addEventListener("faderComplete", faderHandler);
            _fader = new Fader(true);
            addChild(_fader);
            _fader.fadeOut(5, 3);
            var fadeComplete:Timer = new Timer(1000, 6);
            fadeComplete.addEventListener(TimerEvent.TIMER_COMPLETE, faderHandler);
            fadeComplete.start();
            addActText(LEVEL, ACT, TITLE);
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
            //listen for touches that have just ended
            if (touchEnded) {
                trace(event.target);
                if (event.target is Image) {
                    if (Image(event.target).parent.parent.parent is Inventory) {
                        return;
                    }
                    if (Image(event.target).parent.parent.parent is DecisionWheel) {
                        return;
                    }
                    if (Image(event.target).parent.parent.parent is PhoneButton) {
                        return;
                    }
                }
                /*
                 trace(DisplayObject(event.target) as DisplayObject);
                 trace(DisplayObject(event.target).parent as DisplayObject);
                 trace(DisplayObject(event.target).parent.parent as DisplayObject);
                 trace(DisplayObject(event.target).parent.parent.parent as DisplayObject);
                 trace(DisplayObject(event.target).parent.parent.parent.parent as DisplayObject);
                 */
                if (event.target is Item) {
                    var itemTarget:Item;
                    itemTarget = event.target as Item;
                    if (itemTarget.isInInventory()) {
                        itemTarget.triggerInteractionObject();
                        return;
                    }
                }
                //if interaction object handle it
                if (event.target is InteractionObject) {
                    trace("target is interaction object");
                    handleInteractionObject(event.target, {touchX: touchEnded.globalX, touchY: touchEnded.globalY});
                    return;
                }
            }
        }

        override protected function interactionHandler(event:InteractionEvent):void
        {
            trace("interaction handler");
            //get params passed from event
            var interactObject:Object = event.params;
            //listen for when interaction is complete
            this.addEventListener("InteractionComplete", onInteractionComplete);
            //pass the id and handle the state of level
            handleLevelState(interactObject);
        }

        override protected function onInteractionComplete(e:Event):void
        {
            trace("interaction HAS COMPLETED");
            userInteraction(true);
        }

        override protected function handleLevelState(object:Object):void
        {
            this.object = object;
            var id:String = object._id;
            var obj:Object = object._object;
            if (!obj._examinable && id == "middle_compartment") {
                return;
            }

            switch (_currentState) {
                case _PLAYER_IN_CAR :
                    handleState1(object);
                    break;
                case _PLAYER_SPOKE_TO_DRIVER :
                    handleState2(object);
                    break;
                case _PLAYER_LOOKED_OUT_WINDOW :
                    handleState3(object);
                    break;
                case _PLAYER_CHECKED_MIDDLE :
                    handleState4(object);
                    break;
                case _ARRIVED_AT_SLUMS :
                    handleState6(object);
                    break;
                case _READY_TO_LEAVE :
                    handleState7(object);
                    break;
            }
        }

        override protected function createDecisionWheel(object:Object):void
        {
            userInteraction(false);
            if (!GameState.AWAITING_DECISION) {

                //create bg overlay
                _overlay = new Overlay(0.25);
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
                    switch (_currentState) {
                        case _PLAYER_LOOKED_OUT_WINDOW :
                            handleState3(interactionObject);
                            break;
                        case _ARRIVED_AT_SLUMS :
                            handleState6(interactionObject);
                            break;
                    }
                    break;
                case DecisionWheel.CHAT :
                    interactionObject.triggerChat();
                    switch (_currentState) {
                        case _PLAYER_IN_CAR :
                            handleState1(interactionObject);
                            break;
                    }
                    break;
                case DecisionWheel.EXAMINE :
                    if (objectId === 'albert_driving' && examinedAlbert === false) {
                        actScore.addToScore(
							Medals.BONUS_WHOS_THE_DRIVER,
							actScore.getBonusAct().WHOS_DRIVING,
							actScore.getBonusAct().WHOS_DRIVING_SENTENCE,
							actScore.TYPE_BONUS
                        );
                        examinedAlbert = true;
                    }
                    interactionObject.triggerExamine();
                    switch (_currentState) {
                        case _PLAYER_SPOKE_TO_DRIVER :
                            handleState2(interactionObject);
                            break;
                    }
                    break;
            }
            //remove once decision has been made @TODO
            _decisionWheel.removeDecisionWheel();
            _overlay.removeOverlay();
            //reset
            GameState.AWAITING_DECISION = false;
            userInteraction(true);
        }

        /*
         *
         * * * Game Logic * *
         *
         * var id:String = object._id;
         * var type:String = object._type;
         * var obj:String = object._object;
         * var x:String = object._x;
         * var y:String = object._y;
         */
        override public function cleanUp():void
        {
            AlbertAssets.cleanUpMemory();
            Level1DialogueAssets.cleanUpMemory();
            MovingBackgroundSlumsAssets.cleanUpMemory();
        }

        /** State handling **/

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawLevel();
            initializeLevel();
        }

        private function faderHandler(e:TimerEvent):void
        {
            TweenLite.to(_carBg, 4, {x: 0, y: 0, scaleX: 1, scaleY: 1});
            TweenLite.to(_carFg, 4, { x: 0, y: 0, scaleX: 1, scaleY: 1 } );
			
			missionStatementDawson = new MissionStatementDawson();
			missionStatementDawson.addEventListener(Event.REMOVED_FROM_STAGE, allowInteractionAfterStatement);
			addChild(missionStatementDawson);
        }
		
		private function allowInteractionAfterStatement(e:Event):void 
		{
			trace("now user can interact");
			removeEventListener(Event.REMOVED_FROM_STAGE, allowInteractionAfterStatement);
			userInteraction(true);
		}

        private function handleInteractionObject(target:EventDispatcher, properties:Object):void
        {
            trace("handling interaction object in albert journey");
            //get target as an object
            var obj:InteractionObject = InteractionObject(target) as InteractionObject;
            dispatchEvent(new InteractionEvent(
				InteractionEvent.INTERACT, {
					_id: obj._id,
					_type: obj._type,
					_object: obj,
					_x: properties.touchX,
					_y: properties.touchY
				}, true)
            );
        }

        /** Handle state 5 not needed */
        /**
         * @desc if character is albert, try and speak to him and move on to next state
         * @param    object
         */
        private function handleState1(object:Object):void
        {
            createDecisionWheel(object);
            if (_decisionWheel.getCurrentObjectId() == "albert_driving") {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.CHAT) {
                    trace(" setting state to 2");
                    setCurrentState(_PLAYER_SPOKE_TO_DRIVER);
                }
            }
        }

        /**
         * @desc now player has tried to speak with albert, look out the window at the slums
         * @param    object
         */
        private function handleState2(object:Object):void
        {
            createDecisionWheel(object);
            if (_decisionWheel.getCurrentObjectId() == "car_window") {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.EXAMINE) {
                    // now user can try and open compartment
                    _carBg.makeCompartmentExaminable();
                    setCurrentState(_PLAYER_LOOKED_OUT_WINDOW);
                }
            }
        }

        /**
         * @desc  now player has looked out window, try and action the middle compartment
         * @param    object
         */
        private function handleState3(object:Object):void
        {
            createDecisionWheel(object);
            if (_decisionWheel.getCurrentObjectId() == "middle_compartment") {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.ACTION) {
                    triggerThoughtMessage("compartment_locked", 0);
                    _carBg.stopInteriorAmbience();
                    _carBg.stopMovingBackground();
                    // stop car moving about
                    _carBg.turnOffCruise();
                    setCurrentState(_PLAYER_CHECKED_MIDDLE);
                }
            }
        }

        // this signals end of this part
        /**
         * @desc  now you realise compartment is locked Albert will brief Riley
         * @param    object
         */
        private function handleState4(object:Object):void
        {
            if (object._id == "albert_driving") {

                // open dialogue between two
                _dialogueAlbertRiley1 = new AlbertRileyDialogue(AlbertRileyDialogue.CONVO_1);
                if (BlueKarma.ENVIRONMENT === BlueKarma.TESTING) {
                    _dialogueAlbertRiley1.setCurrentState(5);
                }
                addChild(_dialogueAlbertRiley1);
                setCurrentState(_IN_CONVERSATION);
                addEventListener("dialogueFinished", conversationOver);
            }
        }

        /**
         * @desc  now have items in possesion, leave car to finish act.
         * @param    object
         */
        private function handleState6(object:Object):void
        {
            createDecisionWheel(object);
            if (_decisionWheel.getCurrentObjectId() == DigiCuffs.getId()) {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.ACTION) {
                    _inventory.addItem(_carBg.getDigiCuffs());
                }
            }
            if (_decisionWheel.getCurrentObjectId() == LockPick.getId()) {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.ACTION) {
                    _inventory.addItem(_carBg.getLockPick());
                }
            }
            if (_inventory.countItems() >= 2) {
                actScore.addToScore(
					Medals.COLLECT_ENFORCEMENT_GEAR,
					actScore.COLLECT_ENFORCEMENT_GEAR,
					actScore.COLLECT_ENFORCEMENT_GEAR_SENTENCE
                );
                setCurrentState(_READY_TO_LEAVE);
            }
        }
		
        private function handleState7(object:Object):void
        {
            var id:String = object._id;
            if (id == "car_window") {
                trace("getting out of vehicle");
                userInteraction(false);
                // fade in instantly
                _fader.fadeIn(0, 0);
                // Part 1 is now complete move to albert scene
                setChildIndex(_fader, this.numChildren);
                // sound of door opening
                SoundAssets.carDoorOpen.play();
                // play cool tune
                SoundAssets.newLocationTrack.play();
                // play getting out of car
                var timer:Timer = new Timer(1000, 2);
                timer.addEventListener(TimerEvent.TIMER_COMPLETE, albertDriveOff);
                timer.start();
            }
        }

        private function albertDriveOff(e:TimerEvent):void
        {
            // play albert driving off
            SoundAssets.carDriveAway.play();
            var timer:Timer = new Timer(1000, 4);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
            timer.start();
        }

        private function goToNextPart(e:TimerEvent):void
        {
            // notify parent to change act
            dispatchEventWith(Level1.ACT_COMPLETE_LISTENER, true, {level: Level1.ACT_2});
        }

        /** State Changing **/

        private function conversationOver(e:Event):void
        {
            // remove
            removeChild(_dialogueAlbertRiley1);
            // set to new state as player has listened to Albert convo
            setCurrentState(_ARRIVED_AT_SLUMS);
            // remove listener
            removeEventListener("dialogueFinished", conversationOver);
            // make items available to Riley to pick up
            _carBg.openCompartment();
            _inventory.show();
            // open menu
            _inventory.openMenu();
        }
    }
}