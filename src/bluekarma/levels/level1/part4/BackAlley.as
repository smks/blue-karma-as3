package levels.level1.part4
{
    import assets.BackAlleyAssets;
    import assets.components.ECGAssets;
    import assets.GameAssets;
    import assets.GestureAssets;
    import assets.InventoryAssets;
    import assets.ItemAssets;
    import assets.ParticleAssets;
    import assets.PlaqueAssets;
    import assets.PlayerAssets;
	import interactive.backalley.items.Crowbar;
	import interactive.backalley.items.FanKeys;
	import score.medals.Medals;
	import sound.SoundManager;
	import starling.events.TouchProcessor;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.helpers.transitions.Fader;
    import bluekarma.interactive.backalley.repos.BackAlleyInteractionRepo;
    import bluekarma.interactive.base.InteractionObject;
    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;
	TouchProcessor

    import gui.inventory.phonemenu.ActParams;

    import score.Act4Score;

    import com.greensock.easing.Quad;
    import com.greensock.TweenLite;

    import dialogue.phone.components.PhoneButton;

    import events.InteractionEvent;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import global.Global;

    import gui.inventory.Inventory;
    import gui.inventory.PhoneMenu;

    import interactive.backalley.items.ToolboxKey;

    import levels.abstract.AbstractBackAlley;
    import levels.abstract.AbstractLevel;
    import levels.level1.Level1;

    import navigation.PositionArrow;

    import players.AbstractPlayer;
    import players.riley.Riley;

    import settings.backgrounds.BackgroundBackAlley;

    import starling.display.Button;
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
    public class BackAlley extends AbstractBackAlley
    {
		public static const LATE_PENALTY:uint = 2750;
        private const LEVEL:String = "Level 1";
        private const ACT:String = "Act 4";
        private const TITLE:String = "The Back Alley";
        private const TIME_TO_DELAY:Number = 5;
		private var ladderClimb:uint = 0;

        public function BackAlley(act4Score:Act4Score)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
            setLevelActName(InteractionRepoFactory.BACK_ALLEY);
            this.actScore = act4Score;
        }

        override protected function initializeLevel():void
        {
            _fader.fadeOut(4, 2);
            //used to get messages
            _repo = new BackAlleyInteractionRepo();
            addEventListener(InteractionEvent.INTERACT, interactionHandler);
            var timer:Timer = new Timer(1000, TIME_TO_DELAY);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, spanToBelow);
            timer.start();
        }

        /**
         * @desc This handles any touch event interactions in the level
         * @param    event
         */
        override protected function touchInteractionHandler(event:TouchEvent):void
        {
			var touch:Touch = event.getTouch(this);
			
			if (touch == null) {
				
				if (event.target is InteractionObject) {
					var hoverTargetEnded:InteractionObject = event.target as InteractionObject;
                    hoverTargetEnded.setGlow(false);
                }
				
				return;
			}

            //register event listeners for touches
            var playerShouldntMove:Boolean = event.target is Button;
			
			if (touch.phase == TouchPhase.HOVER) {
				if (event.target is InteractionObject) {
					var hoverTarget:InteractionObject = event.target as InteractionObject;
                    hoverTarget.setGlow(true);
                }
			}
			
            //listen for touches that have just ended
            if (touch.phase == TouchPhase.ENDED) {
				
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
                //check for navigation first
                if (event.target is PositionArrow) {
                    var arrowTarget:PositionArrow = event.target as PositionArrow;
                    var showPlayer:Boolean = false;
                    var shouldChange:Boolean = false;
                    // if bottom arrow
                    if (arrowTarget.getId() == "arrow1") {
                        showPlayer = true;
						shouldChange = true;
                    }
                    if (arrowTarget.getId() == "arrow2") {
                        // we are going back to the floor - we need to position player by the ladder
                        if (arrowTarget.x > 200) {
                            _player.x = arrowTarget.x - (_player.width * 1.5);
                            _player.stand(Global.LEFT);
                        } else {
                            _player.x = (arrowTarget.x + _player.width);
                            _player.stand(Global.RIGHT);
                        }
                        shouldChange = true
                    }
                    if (shouldChange) {
						
						ladderClimb++;
						
						if (ladderClimb === 5) {
							actScore.addToScore(
								Medals.BONUS_WORKOUT,
								actScore.getBonusAct().LADDER_CLIMB,
								actScore.getBonusAct().LADDER_CLIMB_SENTENCE,
								actScore.TYPE_BONUS
							);
						}
						
                        SoundAssets.ladderSteps.play();
                        _bg.moveRileysPlaceOnLadder(
                                _bg.getLadder().getCurrentWall(),
                                showPlayer
                        );
                        handlePositionArrow(arrowTarget, _fader, true);
                    } else {
                        triggerThoughtMessage("get_closer");
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
                    trace("handling interaction object");
                    handleInteractionObject(event.target, {touchX: touch.globalX, touchY: touch.globalY});
                    return;
                }
                if (_player !== null && !playerShouldntMove) {
                    //move player
                    if (touch.tapCount == 1) {
                        handlePlayerInteraction(event.target, {xPos: touch.globalX, yPos: touch.globalY});
                        return;
                    }
                }
            }
        }

        override protected function interactionHandler(event:InteractionEvent):void
        {
            trace("caught event, now dealing with it");
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
            // we cannot leave until we have dawson
            if (id === 'metal_fence_door') {
                triggerThoughtMessage("cant_leave");
                return;
            }
            if (id === 'toolbox') {
                var toolBoxKey:Item = _inventory.getItem(ToolboxKey.getId());
                if (toolBoxKey) {
                    if (toolBoxKey.isFocused()) {
                        if (playerAndObjectColliding(_player, _bg.getToolBox())) {
                            this.openToolBoxAndShowItems();
                        } else {
                            triggerThoughtMessage("get_closer");
                        }
                        return;
                    }
                }
            }
            if (id === 'fan-panel') {
                var fanKeys:Item = _inventory.getItem(FanKeys.getId());
                if (fanKeys !== null) {
                    if (fanKeys.isFocused()) {
                        _inventory.removeItem(FanKeys.getId());
                        _bg.openFanPanel();
                        return;
                    }
                }
            }
            if (id === 'window') {
                if (_bg.getFan().isOn()) {
                    if (_bg.getWindow().isOpen() &&
                            _bg.getRileyLadder()
                                    .getCurrentDir() === Global.RIGHT
                    ) {
						
                        // if we haven't picked up cable, we should
                        if (_inventory.getItem('cable') === null) {
                            _inventory.addReminder("back_alley_cable", "look around for more items");
                            triggerThoughtMessage("look_for_more_items");
                            return;
                        }
                        // we're finished - let's continue
                        completeAct();
                        return;
                    }
                }
                // check for crowbar
                var crowbar:Item = _inventory.getItem(Crowbar.getId());
                if (crowbar !== null && crowbar.isFocused()) {
                    _inventory.loseItemFocus();
                    if (_bg.getRileyOnLadderDirection() === Global.LEFT) {
                        triggerThoughtMessage("get_closer");
                        return;
                    }
                    if (_bg.getFan().isOff()) {
                        _inventory.addReminder("make_some_noise", "create a noise distraction");
                        triggerThoughtMessage("make_too_much_noise");
                        return;
                    }
                    if (_bg.getFan().isOn()) {
                        if (_bg.getRileyOnLadderDirection() === Global.RIGHT) {
                            _inventory.loseItemFocus();
                            _inventory.removeItem(Crowbar.getId());
                            _bg.getWindow().open();
                            actScore.addToScore(
                                Medals.BREAK_IN,
								actScore.BREAK_IN,
								actScore.BREAK_IN_SENTENCE
                            );
                        }
                        return;
                    }
                    return;
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
                case DecisionWheel.ACTION :

					//main method to action on all interaction objects
					interactionObject.triggerInteractionObject(params);
						
                    if (objectId === ToolboxKey.getId()) {
                        _inventory.addItem(_bg.getToolBoxKey());
                    }
                    if (objectId === Crowbar.getId()) {
						_bg.getCrowbar().takeFromBox();
                        _bg.getCrowbar().playSound();
                        _inventory.addItem(_bg.getCrowbar());
                    }
                    if (objectId === FanKeys.getId()) {
						_bg.getFanKeys().takeFromBox();
                        _inventory.addItem(_bg.getFanKeys());
                    }
                    if (objectId === 'fan-panel' && _bg.getFanPanel().isUnlocked()) {
							
						// if fan panel is off
						if (_bg.getFanPanel().isOn() === false) {
							
							SoundManager.addSound('slide-latch', SoundAssets.slideLatch);
						
							_bg.getFanPanel().switchOn();
							_bg.getFan().spin();
							
							actScore.addToScore(
								Medals.WE_HAVE_NOISE,
								actScore.WE_HAVE_NOISE,
								actScore.WE_HAVE_NOISE_SENTENCE
							);
							
						} else {
							
							SoundManager.addSound('slide-latch', SoundAssets.slideLatch);
							
							_bg.getFanPanel().switchOff();
							_bg.getFan().turnOff();
						}							
                   
                    } else {
						triggerThoughtMessage("fan_panel_locked");
					}
					
					
                    if (objectId === 'window') {
                        triggerThoughtMessage("cant_with_bare_hands");
                    }
                    break;
                case DecisionWheel.CHAT :
                    interactionObject.triggerChat();
                    break;
                case DecisionWheel.EXAMINE :
                    interactionObject.triggerExamine(params);
                    break;
            }
            _decisionWheel.removeDecisionWheel();
            _overlay.removeOverlay();
            //reset
            GameState.AWAITING_DECISION = false;
            userInteraction(true);
        }

        override protected function prematurelyFinishAct():void
        {
			
			timerCountdownToBeLate.stop();
            timerCountdownToBeLate.removeEventListener(TimerEvent.TIMER, prematurelyFinishAct);
			timerCountdownToBeLate = null;
			
            _fader.fadeIn(0, 0);
            // apply penalty to score
            actScore.removeFromScore(LATE_PENALTY);
			
			removeItemsPrematurely();
			
            var timer:Timer = new Timer(1000, 2);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
            timer.start();
        }
		
		private function removeItemsPrematurely():void 
		{
			// remove items if they exist
			_inventory.removeItem(Crowbar.getId());
			_inventory.removeItem(ToolboxKey.getId());
			_inventory.removeItem(FanKeys.getId());
		}

        override public function cleanUp():void
        {
            BackAlleyAssets.cleanUpMemory();
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawLevel();
            initializeLevel();
            addActText(LEVEL, ACT, TITLE, 1.5, 1.5, 2);
        }

        private function spanToBelow(e:TimerEvent):void
        {
            setCurrentPosition(BackgroundBackAlley.POSITION_2, TIME_TO_SPAN_BG);
            begin();
        }

        private function begin():void
        {
            setMobileProperties();
            addListeners();
            userInteraction(true);
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
				}, true)
            );
        }

        private function handlePlayerInteraction(event:EventDispatcher, properties:Object):void
        {
            //check if exists
            if (_player === null && _decisionWheel.getCurrentAction() !== 'NONE') {
                return;
            }
            if (_player.getPlayerState() === _player.PLAYER_STANDING_STATE) {

                //check if player is in walking range
                _player.playerWalkCheck(
					properties.xPos,
					properties.yPos,
					_backgroundPosition,
					_walkBoundaryUp,
					_walkBoundaryDown,
					_walkBoundaryLeft,
					_walkBoundaryRight
                );
            }
        }

        private function openToolBoxAndShowItems():void
        {
            _inventory.removeItem(ToolboxKey.getId());
            actScore.addToScore(
				Medals.TRADESMEN_TOOLBOX,
				actScore.TRADESMEN_TOOLBOX,
				actScore.TRADESMEN_TOOLBOX_SENTENCE
            );
            _bg.removeToolBoxKey();
            _bg.getToolBox().open();
            _bg.showToolboxItems();
        }

        /**
         * This gets called when Act has completed
         */
        private function completeAct():void
        {
            userInteraction(false);
            // play cool tune
			SoundManager.addSound("break-in-warning", SoundAssets.warningTrack);
            // fade in
            _fader.fadeIn(3, 0);
            var timer:Timer = new Timer(1000, 3);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, goToNextPart);
            timer.start();
        }

        /**
         * This signals end of this part
         *
         * @param e
         */
        private function goToNextPart(e:TimerEvent):void
        {
			// turn off fan noise
			_bg.getFan().stopFanGeneratorSound();
            // notify parent to change level
            dispatchEventWith(Level1.ACT_COMPLETE_LISTENER, true, {level: Level1.ACT_4});
        }
		
		public function triggerItemThoughtMessage(string:String):void 
		{
			triggerThoughtMessage(string);
		}
    }
}