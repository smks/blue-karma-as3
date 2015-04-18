package levels.level1.part1
{
    import adobe.utils.CustomActions;
	import score.medals.Medals;
	import sound.SoundManager;

    import assets.CharacterDialogueSoundAssets;
    import assets.components.ECGAssets;
    import assets.dialogue.Level1DialogueAssets;
    import assets.GameAssets;
    import assets.GestureAssets;
    import assets.InventoryAssets;
    import assets.ItemAssets;
    import assets.ParticleAssets;
    import assets.PlaqueAssets;
    import assets.PlayerAssets;
    import assets.RileyApartmentAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import flash.media.SoundMixer;

    import interactive.apartment.items.KitchenWaterGlass;

    import score.Act1Score;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.components.gestures.hold.Hold;
    import bluekarma.helpers.transitions.Fader;
    import bluekarma.interactive.base.InteractionObject;
    import bluekarma.interactive.base.Item;

    import components.gestures.hold.Select;
    import components.gestures.swipes.Swipe;

    import dialogue.phone.components.PhoneButton;

    import global.Global;

    import gui.inventory.Inventory;
    import gui.inventory.PhoneMenu;
    import gui.inventory.phonemenu.ActParams;

    import helpers.arrows.Arrow;
    import helpers.transitions.ActIntroduction;

    import interactive.apartment.items.Pyjamas;
    import interactive.apartment.props.bedroom.MobilePhone;

    import dialogue.phone.conversations.RileyTyroneOne;

    import events.InteractionEvent;

    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import interactive.apartment.items.WorkClothing;

    import levels.base.RileysApartment;
    import levels.level1.Level1;

    import messages.Message;

    import navigation.PositionArrow;

    import notifications.achievement.Achievement;

    import players.AbstractPlayer;
    import players.riley.Riley;
    import players.riley.RileyAsleep;
    import players.riley.RileyPyjamas;

    import settings.backgrounds.BackgroundRileysApartment;
    import settings.foregrounds.ForegroundRileysApartment;

    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.events.EventDispatcher;
    import starling.events.Touch;
    import starling.events.TouchEvent;

    import interfaces.ILevel;

    import starling.events.Event;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import starling.events.TouchPhase;

    import com.greensock.TweenLite;

    import starling.text.TextField;

    import states.GameState;

    import interactive.apartment.repos.ApartmentInteractionRepo;

    /**
     * ...
     * @author Shaun Stone
     */
    public final class RileysApartmentIntro extends RileysApartment
    {
        private const LEVEL:String = "Level 1";
        private const ACT:String = "Act 1";
        private const TITLE:String = "The Apartment";
        private static const LATE_PENALTY:Number = 2000;
        // timing values
        private const TIME_TO_WAIT_FOR_PHONE_TO_RING:uint = 20; // 20
        private const TIME_TO_FADE_IN_START:uint = 6; // 6
        private const TIME_TO_FADE_IN_DELAY:uint = 6; // 6
        private const STARTING_BG_FG_POS:uint = 3; // start in bedroom
        // list of states (what needs to be changed)
        private const _PLAYER_ASLEEP_1:uint = 1;
        private const _PHONE_RINGING_2:uint = 2; //phone is ringing -> trigger wake up player
        private const _PLAYER_NOW_AWAKE_3:uint = 3; // player awake -> trigger bedroom light
        private const _ANSWER_PHONE_4:uint = 4; // light now on -> touch phone to answer
        private const _PHONE_ANSWERED_5:uint = 5; // in conversation or finished -> trigger hang up phone
        private const _NEED_CLOTHING_6:uint = 6; //touch wardrobe of clothing -> trigger touch wardrobe
        private const _GO_TO_BATHROOM_7:uint = 7; // now have clothing in inventory -> trigger touch bathroom door
        private const _SHOWERED_AND_CLOTHED:uint = 8; // now dressed and showered -> put clothing in wash basket (if open)
        private const _CLOTHES_IN_BASKET:uint = 9; // now dressed and showered -> put clothing in wash basket (if open)
        private const _SPOKE_TO_CRUNCH:uint = 10; // now clothes in basket -> leave bedroom and speak to crunch
        private const _GOT_DOGFOOD:uint = 11; // now have dog food -> place in Crunches bowl
        private const _DOGFOOD_IN_BOWL:uint = 12; // now have dog food -> place in Crunches bowl
        private const _PICKED_UP_FULL_BOWL:uint = 13; // now have dog food -> place in Crunches bowl
        private const _GIVEN_DOG_FOOD:uint = 14; // now given dog food, leave apartment
        private const _READY:uint = 15; // Part 1 now complete go to Albert scene
        private var _rileyAsleep:RileyAsleep;
        private var _mobile:MobilePhone;
        private var _phoneConvoRileyUncle:RileyTyroneOne;
        private var _fader:Fader;
        private var _gameTimer:Timer;
        private var _showerPlay:Sound;
        private var _showerPlayChannel:SoundChannel;
        private var _workClothes:WorkClothing;
        private var _currentPosition:uint = 3;
        private var _mainTitleLabel:TextField;
        private var timerCountdownToBeLate:Timer;
		private var completeTimer:Timer;

        public function RileysApartmentIntro(act1Score:Act1Score)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
            setLevelActName(InteractionRepoFactory.APARTMENT_1);
            this.actScore = act1Score;
        }

        /**
         * @desc sets up level vars
         */
        override protected function initializeLevel():void
        {
            //set the current state to the player asleep
            setCurrentState(_PLAYER_ASLEEP_1);
            //set current position to bedroom
            _currentPosition = STARTING_BG_FG_POS;
            //set background and foreground to this position
            setBackgroundAndForeground(STARTING_BG_FG_POS);
            //setBackgroundAndForegroundTest(1);
            //allow listening for message or item pickups
            activateListeners();
            //used to get messages
            _repo = new ApartmentInteractionRepo();
        }

        override protected function activateListeners():void
        {
            super.activateListeners();
        }

        /**
         * @desc draws level
         */
        override protected function drawLevel():void
        {
            addBackground();
            addSleepingPlayer(775, 450, 1);
            addForeground();
            addRingingMobile();
            addFader();
            addActText(LEVEL, ACT, TITLE);
        }

        override protected function gestureHandler(e:Event):void
        {
            trace("recieved gesture handler event");
            switch (_currentState) {
                case _PHONE_RINGING_2 :
                    trace("handling state 2");
                    // wake riley up
                    handleState2("riley_asleep");
                    break;
                case _PLAYER_NOW_AWAKE_3 :
                    trace("handling state 3");
                    handleState3("light_switch_2");
                    break;
                case _ANSWER_PHONE_4 :
                    trace("handling state 4");
                    handleState4("bedroom_mobile");
                    // allow user interaction
                    userInteraction(true);
                    // remove gesture listening
                    removeGestureListener();
            }
        }

        override protected function addBackground():void
        {
            _apartmentBg = new BackgroundRileysApartment();
            addChild(_apartmentBg);
        }

        override protected function addForeground():void
        {
            _apartmentFg = new ForegroundRileysApartment();
            addChild(_apartmentFg);
            _apartmentFg.turnOffBedroomLights();
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
			
			if (touchHover) {
				
				
				
			}
			
            if (touchEnded) {
				
				if (_player === null) {
					return;
				}

                if (_player.getPlayerState() !== _player.PLAYER_STANDING_STATE) {
                    // we want to wait for the player to be stationary
                    return;
                }
                
                if (event.target is Image) {
                    var targetImage:DisplayObject = Image(event.target).parent.parent.parent;
                    if (targetImage is Inventory) {
                        return;
                    }
                    if (targetImage is DecisionWheel) {
                        return;
                    }
                    if (targetImage is PhoneButton) {
                        return;
                    }
                    if (targetImage is PhoneMenu) {
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
                if (isAPositionArrow(event.target)) {
                    var arrowTarget:PositionArrow;
                    arrowTarget = event.target as PositionArrow;
                    //makes sure player is standing before he can change bg position
                    if (_player.getPlayerState() === _player.PLAYER_STANDING_STATE) {
                        if (arrowTarget.getId() == "arrow3") {
                            // if given dog food, it means you can leave apartment
                            if (_currentState === _GIVEN_DOG_FOOD) {
                                userInteraction(false);
                                trace("current state is", _GIVEN_DOG_FOOD);
                                // Part 1 is now complete move to albert scene
                                setChildIndex(_fader, this.numChildren);
                                // play cool tune
								SoundManager.addSound("discovery-track-long", SoundAssets.discoveryTrackGoodLong, 1, 1);
                                // make player look at screen
                                _player.stand(AbstractPlayer.DIRECTION_DOWN);
                                // fade in
                                _fader.fadeIn(3, 0);
                                completeTimer = new Timer(1000, 3);
                                completeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
                                completeTimer.start();
                            } else {
                                //otherwise state things need to be done still
                                triggerThoughtMessage("cant_leave");
                            }
                        }
                        if (arrowTarget.getDestination()) {
                            arrowTarget.alpha = 0.5;
                            setChildIndex(_fader, this.numChildren);
                            _fader.fadeIn(0, 0);
                            _fader.fadeOut(2, 1);
                            setBackgroundAndForeground(arrowTarget.getDestination());
                            _player.movePlayerPosition(arrowTarget.getTargetXPoint(), arrowTarget.getTargetYPoint(), arrowTarget.getDirection());
                            setWalkingBoundaries();
                        }
                    }
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
                // make sure when button is pressed the player does not walk
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
                _player.setDirectionToTarget(_player.x, interactObject._x, _apartmentBg.getCurrentPosition());
            }
            //pass the id and handle the state of level
            handleLevelState(interactObject);
        }

        override protected function handleLevelState(object:Object):void
        {
            trace("OBJECT IS IS", object._id);
            var id:String = object._id;
            if (universalHandleState(object)) {
                return;
            }
            switch (_currentState) {
                /*
                 case _PHONE_RINGING_2 :
                 handleState2(id);
                 break;
                 case _PLAYER_NOW_AWAKE_3 :
                 handleState3(id);
                 break;
                 case _ANSWER_PHONE_4 :
                 handleState4(id);
                 break;
                 */
                case _NEED_CLOTHING_6 :
                    handleState6(object);
                    break;
                case _GO_TO_BATHROOM_7 :
                    handleState7(object);
                    break;
                case _SHOWERED_AND_CLOTHED :
                    handleState8(object);
                    break;
                case _CLOTHES_IN_BASKET :
                    handleState9(object);
                    break;
                case _SPOKE_TO_CRUNCH :
                    handleState10(object);
                    break;
                case _GOT_DOGFOOD :
                    handleState11(object);
                    break;
                case _DOGFOOD_IN_BOWL :
                    handleState12(object);
                    break;
                case _PICKED_UP_FULL_BOWL :
                    handleState13(object);
                    break;
                case _GIVEN_DOG_FOOD :
                    handleState14(object);
                    break;
                case _READY :
                    handleState15(object);
                    break;
            }
        }

        /**
         * no state 8 handler needed
         */

        override protected function proceedWithDecision(e:Event):void
        {
            removeEventListener("DecisionMade", proceedWithDecision);
            var decision:String = _decisionWheel.getCurrentAction()
            var objectId:String = _decisionWheel.getCurrentObjectId();
            var interactionObject:InteractionObject = _decisionWheel.getCurrentInteractionObject();
            switch (decision) {
                case DecisionWheel.ACTION :

                    // pass optional params to decide what to do with object
                    var params:Object = new Object();
                    params.currentState = _currentState;
                    params.playerPosition = _player.x;
                    params.level = this;
					
					interactionObject.triggerInteractionObject(params);
                        
                    if (objectId === 'kitchen_glass' && _inventory.hasItem(Item(interactionObject) as Item) === false) {
                        _inventory.addItem(Item(interactionObject) as Item);
                    }
                    switch (_currentState) {
                        case _NEED_CLOTHING_6:
                            handleState6(interactionObject);
                            break;

                        //check if state 7 and door is open
                        case _GO_TO_BATHROOM_7:
                            handleState7(interactionObject);
                            break;

                        // check if bedroom pyjamas can be placed in basket
                        case _SHOWERED_AND_CLOTHED:
                            handleState8(interactionObject);
                            break;

                        // check if dog food was picked up
                        case _SPOKE_TO_CRUNCH :
                            handleState10(interactionObject);
                            break;
                        case _GOT_DOGFOOD :
                            handleState11(interactionObject);
                            break;
                        case _DOGFOOD_IN_BOWL :
                            handleState12(interactionObject);
                            break;
                        case _PICKED_UP_FULL_BOWL :
                            handleState13(interactionObject);
                            break;
                    }
                    break;
                case DecisionWheel.CHAT :
                    if (objectId === 'dog_crunch') {
                        if (_apartmentBg.getCrunch().getSpokeTo() === false) {
                            actScore.addToScore(
								Medals.BONUS_MANS_BEST_FRIEND,
								actScore.getBonusAct().MANS_BEST_FRIEND,
								actScore.getBonusAct().MANS_BEST_FRIEND_SENTENCE,
								actScore.TYPE_BONUS
                            );
                            // You have taken the time to speak to dog, give a score
                            _apartmentBg.getCrunch().setSpokeTo(true);
                        }
                    }
                    interactionObject.triggerChat();
                    break;
                case DecisionWheel.EXAMINE :
                    if (objectId === 'smart_window') {
                        _apartmentBg.getSmartWindow().addViewCount();
                        if (_apartmentBg.getSmartWindow().getViewCount() === 3) {
                            actScore.addToScore(
								Medals.BONUS_CITY_ADMIRER,
                                actScore.getBonusAct().CITY_ADMIRER,
								actScore.getBonusAct().CITY_ADMIRER_SENTENCE,
								actScore.TYPE_BONUS
                            );
                        }
                        _player.stand(AbstractPlayer.DIRECTION_UP);
                    }
                    interactionObject.triggerExamine();
                    switch (_currentState) {
                        case _CLOTHES_IN_BASKET :
                            handleState9(interactionObject);
                            break;
                    }
                    break;
            }
            removeDecisionWheel();
            userInteraction(true);
        }

        override protected function onInteractionComplete(e:Event):void
        {
            trace("interaction complete");
        }

        override public function cleanUp():void
        {
            Level1DialogueAssets.cleanUpMemory();
            CharacterDialogueSoundAssets.cleanUpMemory();
            RileyApartmentAssets.cleanUpMemory();
        }

        /**
         *
         * @param    xPos
         * @param    yPos
         * @param    scale
         */

        protected function addSleepingPlayer(xPos:int = 0, yPos:int = 0, scale:Number = 1):void
        {
            _rileyAsleep = new RileyAsleep("riley_asleep", true);
            _rileyAsleep.x = xPos;
            _rileyAsleep.y = yPos;
            addChild(_rileyAsleep);
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
            timerCountdownToBeLate.removeEventListener(
                TimerEvent.TIMER, prematurelyFinishAct
            );
            _fader.fadeIn(0, 0);
            // apply penalty to score
            actScore.removeFromScore(LATE_PENALTY);
			
            completeTimer = new Timer(1000, 2);
			completeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
            completeTimer.start();
        }

        private function universalHandleState(object:Object):Boolean
        {
            var actionMade:Boolean = true;
            if (_inventory.getItemInFocus() == "kitchen_glass") {
                var glass:KitchenWaterGlass = KitchenWaterGlass(_inventory.getItem(_inventory.getItemInFocus())) as KitchenWaterGlass;
                if (object._id === 'kitchen_sink' &&
                        glass.hasWater() === false &&
                        _apartmentBg.getKitchenSink().tapRunning()
                ) {
                    glass.addWater();
                    _inventory.loseItemFocus();
					
					triggerThoughtMessage('fill_the_glass', 3);
					
                    return actionMade;
                } else if (object._id == "plant_pot" && glass.hasWater()) {
                    _apartmentBg.getPlantPot().setWatered(true);
                    // Add Bonus for watering plant
                    actScore.addToScore(
						Medals.BONUS_WATER_PLANTS,
                        actScore.getBonusAct().WATERED_PLANTS, 
						actScore.getBonusAct().WATERED_PLANTS_SENTENCE,
						actScore.TYPE_BONUS
                    );
                    _inventory.removeItem(_inventory.getItemInFocus());
                    return actionMade;
                } else {
                    _inventory.loseItemFocus();
                    triggerThoughtMessage("cant_do_that", 0);
                    return actionMade;
                }
            }
            return false;
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawLevel();
            initializeLevel();
            player_currently_asleep_state_1();
        }

        /**
         * End of Game Logic ########## ###############################################################################
         */

        private function addRingingMobile():void
        {
            _mobile = new MobilePhone("bedroom_mobile", true);
            _mobile.x = 663;
            _mobile.y = 511;
            addChild(_mobile);
        }

        /**
         * Game Logic ####################################################################################################
         * @desc these methods reflect the state of game
         */

        private function player_currently_asleep_state_1():void
        {
            if (BlueKarma.ENVIRONMENT !== BlueKarma.TESTING) {
                // add intro theme
				SoundManager.addSound("apartment-intro", SoundAssets.apartmentIntroBegin, 1, 1);
                //add ambience
				SoundManager.addSound("apartment-ambience", SoundAssets.apartmentCityAmbienceMild, Math.max(), 1);
            }
            _gameTimer = new Timer(1000, TIME_TO_WAIT_FOR_PHONE_TO_RING);
            _gameTimer.addEventListener(TimerEvent.TIMER_COMPLETE, ringPhone);
            _gameTimer.start();
            setCurrentState(_PLAYER_ASLEEP_1);
        }

        private function phone_now_ringing_state_2():void
        {
            //ring the mobile
            _mobile.ringMobile();
            //add listener to interact with user
            addEventListener(InteractionEvent.INTERACT, interactionHandler);
            var wakeRileyGesture:Swipe = new Swipe(Global.LEFT);
            wakeRileyGesture.x = 724;
            wakeRileyGesture.y = 400;
            addChild(wakeRileyGesture);
            listenForGesture();
            //Phone now ringing state
            setCurrentState(_PHONE_RINGING_2);
            //add listener for touch when player is woken up
            userInteraction(true);
        }

        private function player_now_awake_state_3():void
        {
            addListeners();
            setCurrentState(_PLAYER_NOW_AWAKE_3);
            var turnOnLightGesture:Hold = new Hold(2);
            turnOnLightGesture.x = 669;
            turnOnLightGesture.y = 427;
            addChild(turnOnLightGesture);
        }

        private function lightswitch_on_now_answer_phone_4():void
        {
            setCurrentState(_ANSWER_PHONE_4);
            var reachOverGesture:Swipe = new Swipe(Global.LEFT);
            reachOverGesture.x = 649;
            reachOverGesture.y = 400;
            addChild(reachOverGesture);
        }

        // this signals end of this part
        private function phone_answered_now_in_conversation_state_5():void
        {
            setCurrentState(_PHONE_ANSWERED_5);
        }

        private function phonecall_finished_now_get_clothing_state_6():void
        {
            //now player has to get clothing
            setCurrentState(_NEED_CLOTHING_6);
            // make user interaction false
            userInteraction(false);
            //remove event listener
            removeEventListener("PhoneCallEnded", closeConversationAndPrepareInteraction);
            //remove player sleeping
            removeChild(_rileyAsleep, true);
            //remove mobile
            removeChild(_mobile, true);
            //add player
            addPlayableRileyInPyjamas();
            //addInventory
            addInventory();
            //open inventory so user knows it is there
            _inventory.openMenu();
            //close conversation and dispose
            removeChild(_phoneConvoRileyUncle, true);
            //allow the player to walk in boundaries
            setWalkingBoundaries();
            //trigger thought message
            triggerThoughtMessage("get_my_suit", 2);
            //allow user to now interact
            userInteraction(true);
            //make sure player stands down
            _player.stand("down");
        }

        private function got_clothing_now_bathroom():void
        {
            triggerThoughtMessage("out_of_pjs", 1);
            setCurrentState(_GO_TO_BATHROOM_7);
        }

        /**
         * now showered, can access living room and kitchen
         */
        private function showered_and_ready():void
        {
            // remove pyjamas player
            _player.removeFromParent(true);
            //add new riley suited
            _player = new Riley(12);
            _player.x = 146;
            _player.y = 376;
            _player.scaleX = 1.2;
            _player.scaleY = 1.2;
            addChildAt(_player, getChildIndex(_apartmentFg));
            //allow inventory to be accessible
            _inventory.enableInventory();
            //add phone menu and params
            var actParams:ActParams = new ActParams();
            // this will fetch necessary params for this act (1)
            var params:Object = actParams.getLevelOneActOneParams();
            // pass these params into phone menu to enable it
            _inventory.addMobileDashboard(params);
			this.addContacts();
            // Add a timer to check if the player is going to be late
            timerCountdownToBeLate = new Timer(1000);
            timerCountdownToBeLate.addEventListener(TimerEvent.TIMER, checkTimeNotLate);
            timerCountdownToBeLate.start();
            //add push reminder
            _inventory.addReminder("time_constraint", "get ready before 20:00, don't be late", "critical");
            //remove work clothes from inventory
            _inventory.removeItem(_workClothes._id);
            //add pyjamas
            var _pyjamas:Pyjamas = new Pyjamas("bedroom_pyjamas", true);
            //place in inventory right away
            _pyjamas.setInInventory(true);
            //add to inventory
            _inventory.addItem(_pyjamas);
            //animate crunch
            _apartmentBg.animateDog();
            //add navigation arrows
            addNavigationArrows(_apartmentBg.numChildren);
            _fader.fadeOut(4, 0);
			
			SoundManager.addSound("act-1-complete", SoundAssets.discoveryTrackGoodShort, 1, 1);
			
            triggerThoughtMessage("wash_pjs", 5);
            _inventory.addReminder("pyjamas", "prepare pyjamas for washing", "fine");
            setCurrentState(_SHOWERED_AND_CLOTHED);
            userInteraction(true);
            // living room window vehicles
            //_apartmentBg.triggerFlyingVehicles();
        }
		
		private function addContacts():void 
		{
			_inventory.addContact('tyrone', 'Tyrone Marshall', false);
			_inventory.addContact('albert', 'Albert Green', false);
		}

        private function addFader():void
        {
            _fader = new Fader();
            addChild(_fader);
            _fader.fadeOut(TIME_TO_FADE_IN_START, TIME_TO_FADE_IN_DELAY);
        }

        private function isAPositionArrow(target:EventDispatcher):Boolean
        {
            return Boolean(target is PositionArrow);
        }

        private function goToNextPart(e:TimerEvent):void
        {			
			if (completeTimer !== null) {
				completeTimer.stop();
				completeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
				completeTimer = null;
			}
			
            hasLeftBedroomInGoodState();
            hasGoodWaterBills();
            readAllNotifications();
			
			SoundManager.fadeOutAndRemove("apartment-intro");
			//add ambience
			SoundManager.fadeOutAndRemove("apartment-ambience");
			
            // notify parent to change level			
            dispatchEventWith(Level1.ACT_COMPLETE_LISTENER, true, { level: Level1.ACT_1 } );
        }

        private function readAllNotifications():void
        {
            if (_inventory.getPhoneMenu().hasReminders()) {
                return;
            }
            actScore.addToScore(
				Medals.BONUS_NO_NOTIFICATIONS_APARTMENT,
				actScore.getBonusAct().APARTMENT_NOTIFICATIONS,
				actScore.getBonusAct().APARTMENT_NOTIFICATIONS_SENTENCE,
				actScore.TYPE_BONUS
            );
        }

        private function hasGoodWaterBills():void
        {
            if (_apartmentBg.getKitchenSink().tapRunning() === true) {
                return;
            }
            // kitchen sink not running
            actScore.addToScore(
				Medals.BONUS_SAVE_WATER_BILLS,
				actScore.getBonusAct().SAVED_WATER_BILLS,
				actScore.getBonusAct().SAVED_WATER_BILLS_SENTENCE,
				actScore.TYPE_BONUS
            );
        }

        private function hasLeftBedroomInGoodState():void
        {
            if (_apartmentBg.getBedroomChest().getDrawOpen() === true) {
                return;
            }
            if (_apartmentBg.getBed().isBedMade() === false) {
                return;
            }
            if (_apartmentFg.isBedroomLightOn() === true) {
                return;
            }
            if (_apartmentBg.washingBasketOpen()) {
                return;
            }
            // Bedroom is in a good state add bonus score
            actScore.addToScore(
				Medals.BONUS_BEDROOM_MAINTAINER,
				actScore.getBonusAct().BEDROOM_MAINTAINER,
				actScore.getBonusAct().BEDROOM_MAINTAINER_SENTENCE,
				actScore.TYPE_BONUS
            );
        }

        private function handleInteractionObject(target:EventDispatcher, properties:Object):void
        {
            //get target as an object
            var obj:InteractionObject = InteractionObject(target) as InteractionObject;
            dispatchEvent(new InteractionEvent(InteractionEvent.INTERACT, {
                _id: obj._id,
                _type: obj._type,
                _object: obj,
                _x: properties.touchX,
                _y: properties.touchY
            }, true));
        }

        private function stopPhoneRinging(e:Event):void
        {
            removeEventListener("phoneHasBeenAnswered", stopPhoneRinging);
            _mobile.stopRingingMobile();
        }

        private function loadPhoneInterface(e:Event):void
        {
            removeEventListener("phoneHasBeenReachedFor", loadPhoneInterface);
            _phoneConvoRileyUncle = new RileyTyroneOne();
            _phoneConvoRileyUncle.scaleX = 0.5;
            _phoneConvoRileyUncle.scaleY = 0.5;
            _phoneConvoRileyUncle.x = (Game.STAGE_WIDTH / 2);
            _phoneConvoRileyUncle.y = Game.STAGE_HEIGHT;
            addChild(_phoneConvoRileyUncle);
            addEventListener("PhoneCallEnded", closeConversationAndPrepareInteraction);
            TweenLite.to(_phoneConvoRileyUncle, 0.5, {x: 0, y: 0, scaleX: 1, scaleY: 1});
        }

        private function closeConversationAndPrepareInteraction(e:Event):void
        {
            phonecall_finished_now_get_clothing_state_6();
        }

        private function addPlayableRileyInPyjamas():void
        {
            _player = new RileyPyjamas(12);
            _player.x = 680;
            _player.y = 370;
            _player.scaleX = 1.2;
            _player.scaleY = 1.2;
            addChildAt(_player, getChildIndex(_apartmentFg));
            _player.stand("down");
        }

        private function ringPhone(e:TimerEvent):void
        {
            _gameTimer.stop();
            _gameTimer.reset();
            phone_now_ringing_state_2();
        }

        /**
         *
         * @param    id
         */
        private function handleState2(id:String):void
        {
            if (id == 'riley_asleep') {
                _rileyAsleep.wakeUpRiley();
                //set state
                player_now_awake_state_3();
            }
        }

        private function handleState3(id:String):void
        {
            trace("handling state 3 method -- with id: ", id);
            if (id == 'light_switch_2') {

                //turn on bedroom lights
                _apartmentBg.toggleBedroomLight(id);
                //light turned on now answer phone
                lightswitch_on_now_answer_phone_4();
            }
        }

        private function handleState4(id:String):void
        {
            if (id == 'bedroom_mobile') {
                addEventListener("phoneHasBeenReachedFor", loadPhoneInterface);
                _rileyAsleep.makeRileyReachForPhone();
                phone_answered_now_in_conversation_state_5();
                //add event listener to wait for phone to be answered
                addEventListener("phoneHasBeenAnswered", stopPhoneRinging);
            }
        }

        /**
         * no state 5 handler needed
         */

        private function handleState6(object:Object):void
        {
            var id:String = object._id;
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
            if (id == 'bedroom_chest') {
                if (_apartmentBg.isBedroomChestOpen()) {
                    //if work clothes has not yet been added to chest top
                    if (_workClothes === null) {
                        //create new work clothing and add to inventory
                        getOutClothingFromChest();
                    }
                }
            }
            if (_decisionWheel.getCurrentObjectId() == 'work_clothing') {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.ACTION) {

                    // Add Bonus for watering plant
                    actScore.addToScore(
						Medals.FIND_SUIT,
						actScore.FIND_SUIT,
						actScore.FIND_SUIT_SENTENCE
                    );
                    SoundAssets.clothingPickup.play();
                    retrieveClothingFromChest();
                    //now have clothes you can go get ready
                    got_clothing_now_bathroom();
                }
            }
        }

        private function handleState7(object:Object):void
        {
            var id:String = object._id;
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
            if (_decisionWheel.getCurrentObjectId() == "bedroom_door" && _apartmentBg.bedroomDoorOpen()) {
                if (_inventory.hasItem(_workClothes)) {
                    //make sure fader is on top
                    setChildIndex(_fader, this.numChildren);
                    _fader.fadeIn(0, 0);
                    userInteraction(false);
                    showerAndGetReady();
                }
            }
        }

        private function handleState8(object:Object):void
        {
            var id:String = object._id;
            if (_inventory.getItemInFocus() == "bedroom_pyjamas") {
                if (id == "washing_basket" && _apartmentBg.washingBasketOpen()) {
					_inventory.removeItem(_inventory.getItemInFocus());
					triggerThoughtMessage("pjs_in_basket", 1);
					setCurrentState(_CLOTHES_IN_BASKET);
					_inventory.addReminder("check_dog", "check on crunch", "fine");
					// Add Bonus for watering plant
					actScore.addToScore(
						Medals.PYJAMA_WASH,
						actScore.PYJAMA_WASH,
						actScore.PYJAMA_WASH_SENTENCE
					);                   
                    return;
                } else {
                    _inventory.loseItemFocus();
                    triggerThoughtMessage("cant_do_that", 0);
                    return;
                }
            }
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
        }

        /**
         *
         * @param    object
         */
        private function handleState9(object:Object):void
        {
            if (_decisionWheel.getCurrentObjectId() == "dog_crunch") {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.EXAMINE) {
                    if (_currentState > _GO_TO_BATHROOM_7 && _currentState < _SPOKE_TO_CRUNCH) {
                        checkForReminders();
                        setCurrentState(_SPOKE_TO_CRUNCH);
                        _inventory.addReminder("crunch_food", "prepare some food for crunch", "fine");
                    }
                }
            }
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
        }

        /**
         *
         * @param    object
         */
        private function handleState10(object:Object):void
        {
            if (_decisionWheel.getCurrentObjectId() == "dog_food") {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.ACTION) {
                    SoundAssets.dogFoodPickup.play();
                    checkForReminders();
                    var dogFood:Item = _apartmentBg.getDogFood();
                    dogFood.setInInventory(true);
                    _inventory.addItem(dogFood);
                    setCurrentState(_GOT_DOGFOOD);
                    triggerThoughtMessage("picked_up_dog_food", 1);
                }
            }
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
        }

        private function checkForReminders():void
        {
            if (_inventory.hasReminders()) {
                youHaveReminders();
            }
        }

        /**
         *
         * @param    object
         */
        private function handleState11(object:Object):void
        {
            var id:String = object._id;
            if (_inventory.getItemInFocus() == "dog_food") {
                if (id == "dog_bowl") {

                    // remove dog food from inventory
                    _inventory.removeItem("dog_food");
                    // play dog food pouring sound
                    SoundAssets.dogFoodPour.play();
                    // change sprite so it has dog food in it
                    _apartmentBg.fillDogBowlWithFood();
                    // update current state
                    setCurrentState(_DOGFOOD_IN_BOWL);
                    // inform player the dog food was placed in bowl
                    triggerThoughtMessage("placed_dog_food", 1);
                    // return to avoid creating decision wheel
                    return;
                } else {
                    triggerThoughtMessage("cant_do_that", 0);
                    _inventory.loseItemFocus();
                    return;
                }
            }
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
        }

        /**
         *
         * @param    object
         */
        private function handleState12(object:Object):void
        {
            if (_decisionWheel.getCurrentObjectId() == "dog_bowl") {
                if (_decisionWheel.getCurrentAction() == DecisionWheel.ACTION) {
                    var dogBowl:Item = _apartmentBg.getDogBowl();
                    dogBowl.setInInventory(true);
                    // play dog bowl pickup
                    SoundAssets.dropDogBowl.play();
                    _inventory.addItem(dogBowl);
                    setCurrentState(_PICKED_UP_FULL_BOWL);
                }
            }
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
        }

        /**
         *
         * @param    object
         */
        private function handleState13(object:Object):void
        {
            var id:String = object._id;
            if (_inventory.getItemInFocus() == "dog_bowl") {
                if (id == "dog_crunch") {
                    var dogBowl:Item = _inventory.getItem(_inventory.getItemInFocus());
                    _apartmentBg.placeDogBowlByDog(dogBowl);
                    setCurrentState(_GIVEN_DOG_FOOD);
                    _inventory.removeItem(_inventory.getItemInFocus());
                    SoundAssets.dropDogBowl.play();
                    triggerThoughtMessage("better_go", 2);
                    // Add main score for feeding dog
                    actScore.addToScore(
						Medals.RESPONSIBLE_OWNER,
						actScore.RESPONSIBLE_OWNER,
						actScore.RESPONSIBLE_OWNER_SENTENCE
                    );
                    return;
                } else {
                    triggerThoughtMessage("cant_do_that", 0);
                    _inventory.loseItemFocus();
                    return;
                }
            }
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
        }

        private function handleState14(object:Object):void
        {
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
        }

        private function handleState15(object:Object):void
        {
            if (removeItemFocus()) {
                return;
            }
            createDecisionWheel(object);
        }

        /** finished handling state */

        private function showerAndGetReady():void
        {
            // play shower sound
            _showerPlay = SoundAssets.bedroomShower;
            //play shower
            _showerPlayChannel = _showerPlay.play();
            //add listener when it has finished
            _showerPlayChannel.addEventListener(flash.events.Event.SOUND_COMPLETE, whenStoppedShowering);
        }

        private function whenStoppedShowering(e:flash.events.Event):void
        {
            // remove listener when done with it
            _showerPlayChannel.removeEventListener(flash.events.Event.SOUND_COMPLETE, whenStoppedShowering);
            //wrap up level
            showered_and_ready();
        }

        private function getOutClothingFromChest():void
        {
            SoundAssets.clothingGetOut.play();
            //create new work clothing item
            _workClothes = new WorkClothing("work_clothing", true);
            _workClothes.scaleX = 1.3;
            _workClothes.scaleY = 0.9;
            _workClothes.x = 405;
            _workClothes.y = 395;
            addChildAt(_workClothes, getChildIndex(_player));
        }

        private function retrieveClothingFromChest():void
        {
            SoundAssets.clothingPickup.play();
            _inventory.addItem(_workClothes);
        }

        private function handlePlayerInteraction(event:EventDispatcher, properties:Object):void
        {
            //check if exists
            if (_player === null) {
                return;
            }
            if (_player.getPlayerState() === _player.PLAYER_STANDING_STATE) {

                //check if player is in walking range
                _player.playerWalkCheck(properties.xPos, properties.yPos, _backgroundPosition, _walkBoundaryUp, _walkBoundaryDown, _walkBoundaryLeft, _walkBoundaryRight);
            }
        }
    }
}