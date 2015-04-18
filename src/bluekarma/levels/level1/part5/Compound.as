package levels.level1.part5
{
    import adobe.utils.CustomActions;
	import score.medals.Medals;
	import sound.SoundManager;

    import assets.CharacterDialogueMessageAssets;
    import assets.components.ECGAssets;
    import assets.CompoundAssets;
    import assets.dialogue.Level1DialogueAssets;
    import assets.GameAssets;
    import assets.GestureAssets;
    import assets.InventoryAssets;
    import assets.ItemAssets;
    import assets.ParticleAssets;
    import assets.PlaqueAssets;
    import assets.PlayerAssets;
    import assets.RileyCableAssets;

    import bluekarma.interactive.compound.items.MaskingTape;
    import bluekarma.interactive.general.items.DigiCuffs;

    import com.greensock.TweenLite;

    import components.gestures.balancer.BalancerBar;

    import dialogue.character.compound.RileyDawson;
    import dialogue.phone.conversations.RileyAlbertOne;

    import global.Global;

    import gui.inventory.AbstractInventory;
    import gui.inventory.phonemenu.ActParams;

    import score.Act5Score;

    import bluekarma.interactive.compound.characters.Dawson;

    import players.AbstractPlayer;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.components.gestures.hold.Hold;
    import bluekarma.interactive.base.InteractionObject;
    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;

    import dialogue.character.compound.DawsonBodyguards;
    import dialogue.phone.components.PhoneButton;

    import events.InteractionEvent;

    import flash.events.TimerEvent;
    import flash.media.SoundMixer;
    import flash.utils.Timer;

    import gui.inventory.Inventory;
    import gui.inventory.PhoneMenu;

    import levels.abstract.AbstractCompound;
    import levels.level1.Level1;

    import navigation.PositionArrow;

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
     * @author Shaun Stone
     */
    public class Compound extends AbstractCompound
    {
        private const LEVEL:String = "Level 1";
        private const ACT:String = "Act 5";
        private const TITLE:String = "The Compound";
        static public const LATE_PENALTY:uint = 3000;
        private var dawsonAndPauloConvo:DawsonBodyguards;
        private var getOutWindow:Hold;
        private var hideBehindBoxes:Hold;
        private var dawson:Dawson;
        private var timeBeforeDeath:Timer;
        private var rileyDawsonConvo:RileyDawson;
        private var rileyAlbertPickup:RileyAlbertOne;
        private var dawsonInRoom:Boolean = false;
        private var balancerGame:BalancerBar;
        private var timerCountdownToBeLate:Timer;

        public function Compound(act5Score:Act5Score)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
            setLevelActName(InteractionRepoFactory.COMPOUND);
            this.actScore = act5Score;
        }

        override protected function initializeLevel():void
        {
            // show level
            _fader.fadeOut(4, 2);
            //used to get messages
            _repo = InteractionRepoFactory.getInteractionRepo(InteractionRepoFactory.COMPOUND);
            // add interaction handler
            addEventListener(InteractionEvent.INTERACT, interactionHandler);
            // make user interact
            userInteraction(true);
            // set walking boundaries
            setWalkingBoundaries();
            var actParams:ActParams = new ActParams();
            // this will fetch necessary params for this act (1)
            var params:Object = actParams.getLevelOneActFiveParams();
            // pass these params into phone menu to enable it
            _inventory.addMobileDashboard(params);
            // set as worried
			
			if (BlueKarma.ENVIRONMENT !== BlueKarma.TESTING) {
				_inventory.setECGState(_inventory.STATE_WORRIED);
			}
			
			addContacts();
			
			_inventory.addReminder("find_dawson", "arrest dawson before he leaves");
			
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
				
                //trace(event.target);
                if (_player.getPlayerState() !== _player.PLAYER_STANDING_STATE) {
                    // we want to wait for the player to be stationary
                    return;
                }
                if (event.target is Image) {
                    if (Image(event.target).parent === null) {
                        return;
                    }
                    if (Image(event.target).parent.parent === null) {
                        return;
                    }
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
                    trace("handling interaction object");
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
                _player.setDirectionToTarget(_player.x, interactObject._x, _bg.getCurrentPosition());
            }
            //pass the id and handle the state of level
            handleLevelState(interactObject);
        }

        /**
         *
         * @param    object
         */
        override protected function handleLevelState(object:Object):void
        {
            object.level = this;
            var id:String = object._id;
            if (id === Dawson.getId()) {
                if (_inventory.getItemInFocus() === DigiCuffs.getId()) {
                    _bg.cuffDawson();
                    /** play sound of cuffing */
                    SoundAssets.digiCuffsFastened.play();
                    _inventory.removeItem(DigiCuffs.getId());
                    actScore.addToScore(
						Medals.ARREST_DAWSON,
                        actScore.ARREST_DAWSON,
						actScore.ARREST_DAWSON_SENTENCE
                    );
                    giveDawsonArrestSpeech();
					
					_inventory.addReminder("prepare_dawson", "get dawson out the window");
					_inventory.addReminder("tape_dawson", "shut that dawson up");
					_inventory.addReminder("wrap_dawson", "attach the cable to dawson");
					
                    return;
                }
                if (_bg.getDawson() && _bg.getDawson().hasBeenCuffed()) {
					
                    if (_inventory.getItemInFocus() === MaskingTape.getId()) {
                        _inventory.removeItem('masking-tape');
                        SoundAssets.ductTape.play();
                        _bg.getDawson().setTapedUp(true);
						
						triggerThoughtMessage('tape_mouth', 1);
						
						if (_bg.getDawson().readyToBeThrownOut()) {
							
							_inventory.addReminder("arrange_pickup", "let albert know you're ready");
							
							listenForAlbertCall();
						}
						
						return;
						
                    }
                    if (_inventory.getItemInFocus() === 'cable') {
                        SoundAssets.cableWhoosh.play();
                        _bg.getDawson().setTied(true);
                        _inventory.removeItem('cable');
						
						triggerThoughtMessage('cable_ankles', 1);
						
						if (_bg.getDawson().readyToBeThrownOut()) {
							
							_inventory.addReminder("arrange_pickup", "let albert know you're ready");
							
							listenForAlbertCall();
						}
						
						return;
					}
                }
            }
            if (_inventory.getItemInFocus() !== null) {
                _inventory.loseItemFocus();
                triggerThoughtMessage("no");
                return;
            }
            createDecisionWheel(object);
        }

        /**
         *
         * @param e
         */
        override protected function proceedWithDecision(e:Event):void
        {
            removeEventListener("DecisionMade", proceedWithDecision);
            var decision:String = _decisionWheel.getCurrentAction()
            var objectId:String = _decisionWheel.getCurrentObjectId();
            var interactionObject:InteractionObject = _decisionWheel.getCurrentInteractionObject();
            var params:Object = new Object();
            params.level = this;
            params.currentState = _currentState;
            params.playerPosition = _player.x;
            switch (decision) {
                case DecisionWheel.ACTION:
					
					//main method to action on all interaction objects
					interactionObject.triggerInteractionObject(params);
					if (objectId === 'door' && dawsonInRoom === false) {
						setDawsonInRoom(true);
						dawsonAndPauloConvo = new DawsonBodyguards();
						addChild(dawsonAndPauloConvo);
						addEventListener("dialogueFinished", conversationOver);
					}
					if (objectId === 'masking-tape') {
						if (_bg.getMaskingTape().isInInventory() == false) {
							_inventory.addItem(_bg.getMaskingTape());
						}
					}
					
                    break;
                case DecisionWheel.CHAT:
                    interactionObject.triggerChat();
                    break;
                case DecisionWheel.EXAMINE:
                    interactionObject.triggerExamine();
                    break;
            }
            _decisionWheel.removeDecisionWheel();
            _overlay.removeOverlay();
            //reset
            GameState.AWAITING_DECISION = false;
            userInteraction(true);
        }

        override protected function gestureHandler(e:Event):void
        {
            removeGestureListener();
            hasRileyBeenCaught(e, true);
        }

        public function finishBalancerMiniGame(resolution:String):void
        {
            _inventory.setECGState(_inventory.STATE_FINE);
            if (resolution === 'success') {
                this.actScore.addToScore(
					Medals.BONUS_CABLE_BALANCER,
					balancerGame.getScore() + actScore.getBonusAct().CABLE_BALANCER,
					actScore.getBonusAct().CABLE_BALANCER_SENTENCE,
					actScore.TYPE_BONUS
                );
            } else {
                trace("failed to complete balancer game");
            }
            this.removeChild(balancerGame, true);
            completeAct();
        }

        public function getDawsonInRoom():Boolean
        {
            return dawsonInRoom;
        }

        public function setDawsonInRoom(value:Boolean):void
        {
            dawsonInRoom = value;
        }

        public function isDawsonInRoom():Boolean
        {
            return dawsonInRoom;
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
            var timer:Timer = new Timer(1000, 2);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
            timer.start();
        }

        private function giveDawsonArrestSpeech():void
        {
            rileyDawsonConvo = new RileyDawson();
            addChild(rileyDawsonConvo);
            addEventListener("dialogueFinished", conversationOver);
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawLevel();
            initializeLevel();
            addActText(LEVEL, ACT, TITLE, 1.5, 1.5, 2);
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

        private function handlePlayerInteraction(event:EventDispatcher, properties:Object):void
        {
            //check if exists
            if (_player === null && _decisionWheel.getCurrentAction() !== 'NONE') {
                return;
            }
            if (_player.getPlayerState() === _player.PLAYER_STANDING_STATE) {

                //check if player is in walking range
                _player.playerWalkCheck(properties.xPos, properties.yPos, _backgroundPosition, _walkBoundaryUp, _walkBoundaryDown, _walkBoundaryLeft, _walkBoundaryRight);
            }
        }

        /**
         * Dawson is ready to go out the window
         */
        private function callAlbertAndArrangePickup():void
        {
            rileyAlbertPickup = new RileyAlbertOne();
            rileyAlbertPickup.scaleX = 0.5;
            rileyAlbertPickup.scaleY = 0.5;
            rileyAlbertPickup.x = (Game.STAGE_WIDTH / 2);
            rileyAlbertPickup.y = Game.STAGE_HEIGHT;
            addChild(rileyAlbertPickup);
            addEventListener("PhoneCallEnded", closeConversationAndPrepareInteraction);
            TweenLite.to(rileyAlbertPickup, 0.5, {x: 0, y: 0, scaleX: 1, scaleY: 1});
            var timeToAnswerPhone:Timer = new Timer(2000, 1);
            timeToAnswerPhone.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayAnswer);
            // play ringing sound
            SoundAssets.callingSomeone.play();
            timeToAnswerPhone.start();
            function onDelayAnswer(e:TimerEvent):void
            {
                rileyAlbertPickup.phoneAnsweredByReceiver();
            }
        }

        private function closeConversationAndPrepareInteraction(e:Event):void
        {
            //remove event listener
            removeEventListener("PhoneCallEnded", closeConversationAndPrepareInteraction);
            removeChild(_player, true);
            _bg.removeDawson();
            _bg.addRileyHoldingCable();
            addBalancerMiniGame();
            removeChild(rileyAlbertPickup, true);
        }

        private function addBalancerMiniGame():void
        {
            var obj:Object = new Object();
            obj.rileyCable = _bg.getRileyCable();
            balancerGame = new BalancerBar(obj);
            balancerGame.pivotX = balancerGame.width / 2;
            balancerGame.pivotY = balancerGame.height / 2;
            balancerGame.scaleX = -1;
            balancerGame.x = 560;
            balancerGame.y = 170;
            addChild(balancerGame);
            balancerGame.startTimingMiniGame();
            addEventListener("balancerResolution", dealWithBalancerResolution);
            SoundAssets.cableSwinging.play();
            _inventory.setECGState(_inventory.STATE_TERRIFIED);
			
			// listen for 15 seconds, if not done, move on
			var timer:Timer = new Timer(1000, 15);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function miniGameNotDoneInTime(e:TimerEvent):void {
				dispatchEventWith("balancerResolution", false, { resolution: false } );
			});
			
			// play sound of Jake yelling
			addJakeYelling();
			timer.start();
        }
		
		private function addJakeYelling():void 
		{
			SoundManager.addSound('jake-yelling', SoundAssets.jakeYelling);
		} 

        private function dealWithBalancerResolution(e:Event):void
        {
			// remove jake yelling
			SoundManager.fadeOutAndRemove('jake-yelling', 0);
			
            var resolution:String = e.data.resolution;
            removeEventListener("balancerResolution", dealWithBalancerResolution);
            finishBalancerMiniGame(resolution);
        }

        /**
         * This signals end of this part
         *
         * @param e
         */
        private function goToNextPart(e:TimerEvent):void
        {
			_fader.fadeIn(0, 0);
			
            // notify parent to change level
            dispatchEventWith(Level1.ACT_COMPLETE_LISTENER, true, {level: Level1.ACT_5});
        }

        private function conversationOver(e:Event):void
        {
            removeEventListener("dialogueFinished", conversationOver);
            var id:String = e.data.id;
            switch (id) {
                case CharacterDialogueMessageAssets.DAWSON_PABLO:
                    dawsonAndPauloConvo.removeFromParent(true);
                    triggerRushToHide();
                    break;
                case CharacterDialogueMessageAssets.RILEY_DAWSON_1:
                    rileyDawsonConvo.removeFromParent(true);
                    break;
                case CharacterDialogueMessageAssets.RILEY_ALBERT_2:
                    rileyAlbertPickup.removeFromParent(true);
                    break;
            }
        }

        /**
         * This gets called once Dawson has finished his convo
         */
        private function triggerRushToHide():void
        { 
			SoundManager.addSound("compound-walk-in", SoundAssets.walkToDoorAndOpen);
			
            // only reluy
            userInteraction(false);
            // set timer to get it done
            timeBeforeDeath = new Timer(1000, 6);
            timeBeforeDeath.addEventListener(TimerEvent.TIMER_COMPLETE, hasRileyBeenCaught);
            timeBeforeDeath.start();
            // add the multiple choices
            hideBehindBoxes = new Hold(4, "boxes");
            hideBehindBoxes.x = 935;
            hideBehindBoxes.y = 678;
            addChild(hideBehindBoxes);
            getOutWindow = new Hold(20, "window");
            getOutWindow.x = 76;
            getOutWindow.y = 385;
            addChild(getOutWindow);
            // listen for the gesture
            addEventListener("GestureEvent", gestureHandler);
        }

        private function hasRileyBeenCaught(e:*, passed:Boolean = false):void
        {
            timeBeforeDeath.removeEventListener(TimerEvent.TIMER_COMPLETE, hasRileyBeenCaught);
            removeGestureListener();
			
			SoundManager.fadeOutAndRemove("compound-walk-in", 0);
			
			// remove holds
            removeHolds();
            // fade in
            _fader.fadeIn(0, 0);
            if (passed === false) {
				SoundManager.addSound("dawson-sees-riley", SoundAssets.compoundBeenSeen);
                rileyWasCaughtInRoom();
				return;
            } else {
                rileyHidBehindBoxes();
            }
			
			_player.setDirection(AbstractPlayer.DIRECTION_LEFT);
        }

        /**
         * @scenario Passed hiding - add points 8000
         */
        private function rileyHidBehindBoxes():void
        {
			// shout from dawson he is the room
			SoundAssets.notificationSuccessHigh.play();
			
			this.actScore.addToScore(
				Medals.HIDE_AND_SEEK,
				actScore.getBonusAct().HIDE_IN_GOOD_TIME,
				actScore.getBonusAct().HIDE_IN_GOOD_TIME_SENTENCE,
				actScore.TYPE_BONUS
			);
			
			addDawson();
			
            // play back pack being opened
            SoundAssets.fastenBackpack.play();
            
        }

        /**
         * @scenario Failed to hide - lose points 3500
         */
        private function rileyWasCaughtInRoom():void
        {
			// lose points
			actScore.removeFromScore(3500);
			
			// shout from dawson he is the room
			SoundAssets.notificationSuccessLow.play();
			
			// add timer to wait
			var timer:Timer = new Timer(1000, 4);
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
				trace("WAS CAUGHT NOW DEALING WITH DAWSON");
				// fast forward to when Dawson is cuffed
				addDawson(true);
				
				giveDawsonArrestSpeech();
			});
			
			timer.start();
        }
		
		private function addDawson(wasSeen:Boolean = false):void 
		{
			// add dawson sitting
            _bg.addDawson();
			
			// player was seen
			if (wasSeen === true) {
				
				_bg.getDawson().cuffDawson();
				
				if (_inventory.hasItem(_bg.getMaskingTape())) {
					_inventory.removeItem(MaskingTape.getId());
				} else {
					_bg.removeMaskingTape();
				}
				
				_bg.getDawson().setTapedUp(true);
				
				if (_inventory.getItem(DigiCuffs.getId())) {
					_inventory.removeItem(DigiCuffs.getId());
				}
				
				SoundAssets.digiCuffsFastened.play();
				
				_player.x = 350;
			}
			
            // fade out
            _fader.fadeOut(2, 2);
			
			// allow user interaction
            userInteraction(true);
		}

        /**
         * @return boolean
         */
        private function holdsExist():Boolean
        {
            return (hideBehindBoxes !== null) ? true : false;
        }

        private function removeHolds():void
        {
            if (getOutWindow !== null) {
                getOutWindow.removeFromParent(true);
            }
            if (hideBehindBoxes !== null) {
                hideBehindBoxes.removeFromParent(true);
            }
        }
		
		public function listenForAlbertCall():void
		{
			if (hasEventListener("MakeACallFromPhoneMenu")) {
				
				trace("ALREADY! Listening for Albert Call");
				
				return;
			}
			
			trace("Listening for Albert Call");
			
			addEventListener("MakeACallFromPhoneMenu", dealWithAlbertCall);
		}
		
		private function dealWithAlbertCall(e:Event):void 
		{
			if (e.data.id !== 'albert') {
				return;
			}
			
			removeEventListener("MakeACallFromPhoneMenu", dealWithAlbertCall);
			_inventory.addReminder("slowly_does_it", "ease dawson out the window slowly");
			_inventory.closeMobileDashboard();
			userInteraction(false);
			callAlbertAndArrangePickup();
		}
		
		private function addContacts():void 
		{
			_inventory.addContact('tyrone', 'Tyrone Marshall', false);
			_inventory.addContact('albert', 'Albert Green', true);
		}
		
		override public function cleanUp():void
        {
            ECGAssets.cleanUpMemory();
            Level1DialogueAssets.cleanUpMemory();
            GameAssets.cleanUpMemory();
            GestureAssets.cleanUpMemory();
            ParticleAssets.cleanUpMemory();
            PlayerAssets.cleanUpMemory();
            ItemAssets.cleanUpMemory();
            PlaqueAssets.cleanUpMemory();
            CompoundAssets.cleanUpMemory();
            RileyCableAssets.cleanUpMemory();
        }
		
		/**
         * This gets called when Act has completed
         */
        private function completeAct():void
        {
            flash.media.SoundMixer.stopAll();
            userInteraction(false);
            // play cool tune
			SoundManager.addSound("compound-end", SoundAssets.warningTrack);
            // fade in
            _fader.fadeIn(0, 0);
			
			var timer:Timer = new Timer(1000, 5);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
				setupShowingJake();
			});
			timer.start();
        }
		
		private function setupShowingJake():void 
		{
			SoundManager.fadeOutAndRemove("compound-end", 5);
			SoundManager.addSound('he-gone', SoundAssets.jakeHeHasGone);
			
			_bg.openDoor();
			_bg.removeRileyCable();
			_bg.removeBackpackAndMash();
			_bg.addJakeLooking();
			_fader.fadeOut(2, 4);
			
			var timer:Timer = new Timer(1000, 4);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, fadeTheLevelOut);
			timer.start();
		}
		
		private function fadeTheLevelOut(e:TimerEvent):void 
		{
			_fader.fadeIn(2, 1);
			
			var timer:Timer = new Timer(1000, 8);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
			timer.start();
		}
    }
}