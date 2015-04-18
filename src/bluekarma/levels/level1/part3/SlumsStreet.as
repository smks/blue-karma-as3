package levels.level1.part3
{
    import adobe.utils.CustomActions;
	import score.medals.Medals;
	import sound.SoundManager;

    import assets.components.ECGAssets;
    import assets.dialogue.Level1DialogueAssets;
    import assets.GameAssets;
    import assets.GestureAssets;
    import assets.InventoryAssets;
    import assets.ItemAssets;
    import assets.Level1Assets;
    import assets.NotificationsAssets;
    import assets.ParticleAssets;
    import assets.PlaqueAssets;
    import assets.PlayerAssets;
    import assets.PropAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import flash.media.SoundMixer;

    import global.Global;

    import score.Act3Score;

    import bluekarma.dialogue.character.slumsstreet.riley_rupert.RileyRupert;

    import assets.CharacterDialogueMessageAssets;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.components.conditions.ECG;
    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.components.gestures.hold.Hold;
    import bluekarma.helpers.transitions.Fader;
    import bluekarma.interactive.base.InteractionObject;
    import bluekarma.interactive.base.Item;
    import bluekarma.interactive.general.items.DigiCuffs;
    import bluekarma.interactive.general.items.LockPick;
    import bluekarma.interactive.slumsstreet.repos.SlumsStreetInteractionRepo;
    import bluekarma.levels.abstract.AbstractSlumsStreet;

    import components.gestures.hold.Select;

    import dialogue.character.slumsstreet.riley_bodyguards.RileyBodyguards;
    import dialogue.phone.components.PhoneButton;

    import events.InteractionEvent;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import gui.inventory.Inventory;
    import gui.inventory.PhoneMenu;
    import gui.inventory.phonemenu.ActParams;

    import helpers.utils.Duration;

    import interactive.apartment.repos.ApartmentInteractionRepo;

    import levels.abstract.AbstractLevel;
    import levels.level1.Level1;

    import navigation.PositionArrow;
    import notifications.reminders.Reminder;

    import players.AbstractPlayer;

    import settings.foregrounds.Overlay;

    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.events.Event;
    import starling.events.EventDispatcher;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    import states.GameState;

    /**
     * @author Shaun Stone 2015
     *
     */
    public class SlumsStreet extends AbstractSlumsStreet
    {
        private const LEVEL:String = "Level 1";
        private const ACT:String = "Act 3";
        private const TITLE:String = "The Slums Street";
        private const TIME_TO_FADE_IN_START:uint = 4; // 4
        private const TIME_TO_FADE_IN_DELAY:uint = 3; // 2
        private const STARTING_BG_FG_POS:uint = 1; // start from left
        private const TIME_TO_FADE_TO_REMOVE_GANG:uint = 1;
        public static const LATE_PENALTY:uint = 2500;
        /**
         * List of states
         */
        private const _PLAYER_ARRIVED:uint = 1; // First check if your in the correct zone -> exmaine sign
        private const _IDENTIFIED_COMPOUND:uint = 2; // now you know where you are, look for the compound
        private const _SPOKE_TO_GUARDS:uint = 3; // player awake -> trigger bedroom light
        private const _USED_LOCKPICK_ON_FENCE:uint = 4; // Used lockpick on gate
        private const _COMPLETE:uint = 5; // level complete
        private var _fader:Fader;
        private var duration:Duration;
        private var _rileyBodyguards:RileyBodyguards;
        private var _rileyRupert:RileyRupert;
        private var _arrow7:PositionArrow;	
        private var rupertAnnoyedYou:Boolean;
        private var rupertIsWatching:Boolean = true;
        private var timerCountdownToBeLate:Timer;
        private var checkedSign:Boolean;
        private var checkedOtherHouse:Boolean = false;
		private var completeTimer:Timer;
		
        public function SlumsStreet(act3Score:Act3Score)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
            setLevelActName(InteractionRepoFactory.SLUMS_STREET);
            this.actScore = act3Score;
        }

        /**
         * @desc sets up level vars
         */
        override protected function initializeLevel():void
        {
            //set the current state to the player asleep
            setCurrentState(_PLAYER_ARRIVED);
            //set current position to bedroom
            _backgroundPosition = STARTING_BG_FG_POS;
            //set background and foreground to this position
            setBackgroundAndForeground(_backgroundPosition);
            // black out
            addFader();
            //allow listening for messages
            activateListeners();
            // set walking boundaries
            setWalkingBoundaries();
            //used to get messages
            _repo = new SlumsStreetInteractionRepo();
            //add phone menu and params
            var actParams:ActParams = new ActParams();
            // this will fetch necessary params for this act (1)
            var params:Object = actParams.getLevelOneActThreeParams();
            // pass these params into phone menu to enable it
            _inventory.addMobileDashboard(params);
			addContacts();
            // Add a timer to check if the player is going to be late
            timerCountdownToBeLate = new Timer(1000);
            timerCountdownToBeLate.addEventListener(TimerEvent.TIMER, checkTimeNotLate);
            timerCountdownToBeLate.start();
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
            //listen for touches that have just ended
            if (touchEnded) {
				
				if (_player === null) {
					return;
				}

                if (_player.getPlayerState() !== _player.PLAYER_STANDING_STATE) {
                    // we want to wait for the player to be stationary
                    return;
                }

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
                    if (Image(event.target).parent.parent.parent is PhoneMenu) {
                        return;
                    }
                }
                //trace(DisplayObject(event.target) as DisplayObject);
                //trace(DisplayObject(event.target).parent as DisplayObject);
                //trace(DisplayObject(event.target).parent.parent as DisplayObject);
                //trace(DisplayObject(event.target).parent.parent.parent as DisplayObject);
                //trace(DisplayObject(event.target).parent.parent.parent.parent as DisplayObject);
                //check for navigation first
                if (event.target is PositionArrow) {
                    var arrowTarget:PositionArrow = event.target as PositionArrow;
                    if (arrowTarget.getId() == "arrow7") {
                        completeAct();
                        return;
                    }
                    handlePositionArrow(arrowTarget, _fader);
                    return;
                }
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
                    handleInteractionObject(event.target, {touchX: touchEnded.globalX, touchY: touchEnded.globalY});
                    return;
                }
                if (_player !== null && !playerShouldntMove) {

                    //move player
                    if (touchEnded.tapCount == 1) {
                        handlePlayerInteraction(event.target, {xPos: touchEnded.globalX, yPos: touchEnded.globalY});
                        return;
                    }
                }
            }
        }

        override protected function interactionHandler(event:InteractionEvent):void
        {

            //get params passed from event
            var interactObject:Object = event.params;
            //listen for when interaction is complete
            this.addEventListener("InteractionComplete", onInteractionComplete);
            if (_player !== null) {
                _player.setDirectionToTarget(_player.x, interactObject._x, _bgStreet.getCurrentPosition());
            }
            //pass the id and handle the state of level
            handleLevelState(interactObject);
        }

        override protected function handleLevelState(object:Object):void
        {
            var id:String = object._id;
            switch (_currentState) {
                case _PLAYER_ARRIVED:
                    handleState1(object);
                    break;
                case _IDENTIFIED_COMPOUND:
                    handleState2(object);
                    break;
                case _SPOKE_TO_GUARDS:
                    handleState3(object);
                    break;
                case _USED_LOCKPICK_ON_FENCE:
                    handleState4(object);
                    break;
                default:
                    throw new Error("State not found");
            }
        }

        override protected function proceedWithDecision(e:Event):void
        {
            removeEventListener("DecisionMade", proceedWithDecision);
            var decision:String = _decisionWheel.getCurrentAction()
            var objectId:String = _decisionWheel.getCurrentObjectId();
            var interactionObject:InteractionObject = _decisionWheel.getCurrentInteractionObject();
            switch (decision) {
                case DecisionWheel.ACTION:

                    // pass optional params to decide what to do with object
                    var params:Object = new Object();
                    params.currentState = _currentState;
                    params.playerPosition = _player.x;
					
						if (objectId === 'metal-gate' && rupertIsWatching === true) {
							triggerThoughtMessage('rupert_is_watching');
							removeDecisionWheel();
							userInteraction(true);
							return;
						}
						switch (_currentState) {
							case _USED_LOCKPICK_ON_FENCE:
								handleState4(interactionObject);
								break;
						}
						//main method to action on all interaction objects
						interactionObject.triggerInteractionObject(params);
                        
                    break;
                case DecisionWheel.CHAT:
                    interactionObject.triggerChat();
						switch (_currentState) {
							case _IDENTIFIED_COMPOUND:
								handleState2(interactionObject);
								break;
						}
						
                    break;
                case DecisionWheel.EXAMINE:
                    if (objectId === 'road-sign' && checkedSign === false) {
                        actScore.addToScore(
                            Medals.BONUS_STREET_CHECK,
							actScore.getBonusAct().STREET_SIGN_CHECK,
							actScore.getBonusAct().STREET_SIGN_CHECK_SENTENCE,
							actScore.TYPE_BONUS
                        );
                        checkedSign = true;
                    }
                    if (objectId === 'house-door' && checkedOtherHouse === false) {
                        actScore.addToScore(
							Medals.BONUS_HOUSE_CHECKER,
							actScore.getBonusAct().HOUSE_CHECKER,
							actScore.getBonusAct().HOUSE_CHECKER_SENTENCE,
							actScore.TYPE_BONUS
                        );
                        checkedOtherHouse = true;
                    }
                    interactionObject.triggerExamine();
                    switch (_currentState) {
                        case _PLAYER_ARRIVED:
                            handleState1(interactionObject);
                            break;
                        case _SPOKE_TO_GUARDS:
                            handleState3(interactionObject);
                            break;
                    }
                    break;
            }
            removeDecisionWheel();
            userInteraction(true);
        }

        override public function cleanUp():void
        {
            Level1DialogueAssets.cleanUpMemory();
            Level1Assets.cleanUpMemory();
            PropAssets.cleanUpMemory();
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

        private function prematurelyFinishAct():void
        {
			timerCountdownToBeLate.stop();
            timerCountdownToBeLate.removeEventListener(TimerEvent.TIMER, prematurelyFinishAct);
			timerCountdownToBeLate = null;
			
            _fader.fadeIn(0, 0);
            // apply penalty to score
            actScore.removeFromScore(LATE_PENALTY);
            completeTimer = new Timer(1000, 2);
            completeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
            completeTimer.start();
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawLevel();
            initializeLevel();
            addActText(LEVEL, ACT, TITLE, 1.5, 1.5, 2);
            // begin
            player_arriving();
        }

        /**
         * Game Logic ####################################################################################################
         * @desc these methods reflect the state of game
         */

        private function player_arriving():void
        {
            if (BlueKarma.ENVIRONMENT !== BlueKarma.TESTING) {
                // play street ambience
				SoundManager.addSound("slums-ambience", SoundAssets.slumsAmbience, int.MAX_VALUE, 0);
            }
            // assign two items
            assignItemsFromAlbertsVehicle();
            // wait for certain duration for player to arrive
            waitForPlayerToArrive();
        }

        /**
         * These items are given by Albert
         */
        private function assignItemsFromAlbertsVehicle():void
        {
            return;
            /**
             * REMOVE!
             */
            var cuffs:DigiCuffs = new DigiCuffs(DigiCuffs.getId(), true);
            cuffs.setLevelItem(DigiCuffs.STREETS);
            _inventory.addItem(cuffs);
            var lockpick:LockPick = new LockPick(LockPick.getId(), true);
            cuffs.setLevelItem(DigiCuffs.STREETS);
            _inventory.addItem(lockpick);
        }

        private function waitForPlayerToArrive():void
        {
            var timer:Timer = new Timer(1000, 3);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, whenPlayerArrived);
            timer.start();
        }

        private function whenPlayerArrived(e:TimerEvent):void
        {
            // make player walk in
            _player.walkTo(AbstractPlayer.DIRECTION_RIGHT, 400);
            // allow user to touch
            userInteraction(true);
            _inventory.addReminder("find_compound", "find the compound", Reminder.CRITICAL);
            // interaction with things
            addEventListener(InteractionEvent.INTERACT, interactionHandler);
			
			triggerThoughtMessage('look_for_compound', 4);
        }

        /**
         * End of Game Logic ########## ###############################################################################
         */

        private function addFader():void
        {
            _fader = new Fader();
            addChild(_fader);
            _fader.fadeOut(TIME_TO_FADE_IN_START, TIME_TO_FADE_IN_DELAY);
        }

        private function handleInteractionObject(target:EventDispatcher, properties:Object):void
        {
            //get target as an object
            var obj:InteractionObject = InteractionObject(target) as InteractionObject;
            trace("dispatching interaction event");
            dispatchEvent(new InteractionEvent(InteractionEvent.INTERACT, {
                _id: obj._id,
                _type: obj._type,
                _object: obj,
                _x: properties.touchX,
                _y: properties.touchY
            }, true));
        }

        private function handlePlayerInteraction(event:EventDispatcher, properties:Object):void
        {
            //check if exists
            if (_player === null) {
                return;
            }
            if (_player.getPlayerState() === _player.PLAYER_STANDING_STATE) {

                // if ruper is nearby make him call out
                if (playerAndObjectColliding(_player, _bgStreet.getRupert())) {
                    if (notBeenAnnoyedByRupert()) {
                        return;
                    }
                }
                //check if player is in walking range
                _player.playerWalkCheck(properties.xPos, properties.yPos, _backgroundPosition, _walkBoundaryUp, _walkBoundaryDown, _walkBoundaryLeft, _walkBoundaryRight);
            }
        }

        private function notBeenAnnoyedByRupert():Boolean
        {
            if (rupertAnnoyedYou === true) {
                return false;
            }
            rupertAnnoyedYou = true;
            var timeToWait:Timer = new Timer(1000, 10);
            timeToWait.addEventListener(TimerEvent.TIMER_COMPLETE, allowRupertToAnnoyAgain);
            timeToWait.start();
            function allowRupertToAnnoyAgain(e:TimerEvent):void
            {
                rupertAnnoyedYou = false;
            }

            _rileyRupert = new RileyRupert();
            addChild(_rileyRupert);
            addEventListener("dialogueFinished", conversationOver);
            return true;
        }

        private function handleState1(object:Object):void
        {
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
            if (_decisionWheel.getCurrentObjectId() == 'compound-door') {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.EXAMINE) {
                    actScore.addToScore(
						Medals.FIND_COMPOUND,
						actScore.FIND_COMPOUND,
						actScore.FIND_COMPOUND_SENTENCE
                    );
                    setCurrentState(_IDENTIFIED_COMPOUND);
                }
            }
        }

        private function handleState2(object:Object):void
        {
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
            if (_decisionWheel.getCurrentObjectId() == 'pablo' || _decisionWheel.getCurrentObjectId() == 'jacob') {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.CHAT) {
                    _player.stand(AbstractPlayer.DIRECTION_UP);
                    _rileyBodyguards = new RileyBodyguards('riley_bodyguards_1', this);
                    if (BlueKarma.ENVIRONMENT === BlueKarma.TESTING) {
                        _rileyBodyguards.setCounter(14);
                    }
                    addChild(_rileyBodyguards);
                    _inventory.addReminder("find_another_way_in", "find another way into the compound", Reminder.CRITICAL);
                    addEventListener("dialogueFinished", conversationOver);
                    setCurrentState(_SPOKE_TO_GUARDS);
                    _bgStreet.setRupertSleep();
                    rupertIsWatching = false;
                }
            }
        }

        private function handleState3(object:Object):void
        {
            if (_inventory.getItemInFocus() == LockPick.getId()) {
                if (object._id == "metal-gate") {
                    _inventory.removeItem(LockPick.getId());
                    SoundAssets.fenceUnlock.play();
                    actScore.addToScore(
                        Medals.ANOTHER_WAY,    
                        actScore.ANOTHER_WAY,
						actScore.ANOTHER_WAY_SENTENCE
                    );
					
					triggerThoughtMessage('unlocked_fence', 1);
					
                    setCurrentState(_USED_LOCKPICK_ON_FENCE);
                }
                else {
                    _inventory.loseItemFocus();
                    triggerThoughtMessage("cant_do_that", 0);
                }
                return;
            }
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
            if (_decisionWheel.getCurrentObjectId() == 'metal-gate') {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.EXAMINE) {
                    _inventory.addReminder("find_way_through_fence", "find a way through side of compound", Reminder.HIGH);
                }
            }
        }

        /**
         * @param object
         */
        private function handleState4(object:Object):void
        {
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
            if (_decisionWheel.getCurrentObjectId() == 'metal-gate') {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.ACTION) {
                    if (_bgStreet.isMetalGateOpen() === false) {
                        SoundAssets.metalGateOpen.play();
                        _bgStreet.openMetalGate();
                        // add new nav arrow
                        addExitArrow();
                    }
                }
            }
        }

        private function completeAct():void
        {
            userInteraction(false);
            // play cool tune
            SoundAssets.discoveryTrackGoodLong.play();
            // make player look at screen
            _player.stand(AbstractPlayer.DIRECTION_UP);
            // fade in
            _fader.fadeIn(3, 0);
            completeTimer = new Timer(1000, 3);
            completeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
            completeTimer.start();
        }

        /**
         * This signals end of this part
         *
         * @param e
         */
        private function goToNextPart(e:TimerEvent):void
        {
			completeTimer.stop();
			completeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
			completeTimer = null;
			
            checkEveryoneBeenExamined();
            readAllNotifications();
			
			SoundManager.fadeOutAndRemove("slums-ambience");
			
            dispatchEventWith(Level1.ACT_COMPLETE_LISTENER, true, {level: Level1.ACT_3});
        }

        private function checkEveryoneBeenExamined():void
        {
            if (_bgStreet.everyoneExamined() === true) {
                actScore.addToScore(
					Medals.BONUS_FULL_VETTER,
					actScore.getBonusAct().FULL_VETTER,
					actScore.getBonusAct().FULL_VETTER_SENTENCE,
					actScore.TYPE_BONUS
                );
            }
        }

        private function readAllNotifications():void
        {
            if (_inventory.getPhoneMenu().hasReminders()) {
                return;
            }
            actScore.addToScore(
				Medals.BONUS_SLUMS_NOTIFICATIONS,
                actScore.getBonusAct().SLUMS_NOTIFICATIONS_CLEAR,
				actScore.getBonusAct().SLUMS_NOTIFICATIONS_CLEAR_SENTENCE,
				actScore.TYPE_BONUS
            );
        }

        /**
         * This will allow the player to finish the act
         */
        private function addExitArrow():void
        {
            _arrow7 = new PositionArrow("arrow7", true);
            _arrow7.setRotation(_arrow5.DIRECTION_UP);
            _arrow7.x = 1586;
            _arrow7.y = 543;
            _arrow7.scaleY = 0.5;
            positionArrowList.push(_arrow7);
            _bgStreet.addChild(_arrow7);
        }

        private function conversationOver(e:Event):void
        {
            removeEventListener("dialogueFinished", conversationOver);
            var id:String = e.data.id;
            switch (id) {
                case CharacterDialogueMessageAssets.RILEY_BODYGUARDS_1:
                    _rileyBodyguards.removeFromParent(true);
                    break;
                case CharacterDialogueMessageAssets.RILEY_RUPERT_1:
                    _rileyRupert.removeFromParent(true);
                    break;
            }
        }
		
		private function addContacts():void 
		{
			_inventory.addContact('tyrone', 'Tyrone Marshall', false);
			_inventory.addContact('albert', 'Albert Green', false);
		}
    }
}