package levels.abstract
{
    //starling framework classes
    import adobe.utils.CustomActions;

    import bluekarma.components.decisions.DecisionWheel;
    import bluekarma.interactive.base.InteractionObject;
    import bluekarma.interactive.base.Item;

    import flash.utils.Dictionary;

    import dialogue.phone.components.PhoneButton;

    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    import flash.media.Sound;
    import flash.utils.Timer;

    import gui.inventory.PhoneMenu;

    import helpers.transitions.ActIntroduction;

    import interfaces.ILevel;

    import gui.inventory.Inventory;

    import messages.Message;

    import notifications.achievement.Achievement;
    import notifications.modal.Modal;

    import players.AbstractPlayer;
    import players.riley.Riley;

    import settings.backgrounds.BackgroundSlumsAlley;
    import settings.foregrounds.slums_street.ForegroundSlumsStreet;
    import settings.foregrounds.Overlay;

    import helpers.GameClock;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.EventDispatcher;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    import starling.display.Quad;

    import events.InteractionEvent;

    //flash classes
    import flash.geom.Point;
    import flash.utils.describeType;
    import flash.globalization.DateTimeFormatter;

    //import all assets
    import bluekarma.assets.sound.SoundAssets;

    import assets.CharacterDialogueAssets;
    import assets.Level1Assets;

    import helpers.GameClock;

    import starling.events.TouchProcessor;

    //import buttons
    //import states
    import states.GameState;

    //import player class
    import players.Player;

    //import inventory
    /**
     * @author Shaun Stone
     */
    public class AbstractLevel extends Sprite
    {
		protected var actScore:*;
        public const TOUCH_DURATION_EXPECTED:uint = 500;
        //this will provide a real time clock to track time
        protected var _gameClock:GameClock;
        //this is the controllable player
        protected var _player:AbstractPlayer;
        //overlay
        protected var _overlay:Overlay;
        //this is the decision wheel
        protected var _decisionWheel:DecisionWheel;
        //inventory interface
        protected var _inventory:Inventory;
        //black transparent overlay
        protected var _bgOverlay:Image;
        //used to keep track of how far the user has progressed in the game
        protected var _progressId:uint = 0;
        //This is the current state of the game
        protected var _currentState:uint = 1;
        //This is used to know what background to show
        protected var _backgroundPosition:uint = 1;
        //This determines if interaction can be made with level (false by default)
        protected var _interaction:Boolean = false;
        protected var _repo:*;
        //walking boundaries (up, down, left right)
        protected var _walkBoundaryUp:int;
        protected var _walkBoundaryDown:int;
        protected var _walkBoundaryLeft:int;
        protected var _walkBoundaryRight:int;
        //This is used to count how many items the user currently has
        protected var _itemsStored:uint = 0;
        //This is used to see the current item highlighted
        protected var _currentItem:String;
        //This is used to count how many items have been trashed
        protected var _itemsTrashed:uint = 0;
        //This is used to count how many items have been examined
        protected var _itemsExamined:uint = 0;
        //This is used to count how many people the user has spoken to
        protected var _peopleSpokenTo:uint = 0;
        //This is used to count how many good questions asked
        protected var _decisionCorrect:uint = 0;
        //This is used to count how many bad decisions have been made
        protected var _decisionWrong:uint = 0;
        //This is the artificial money in the game
        protected var _bitCash:Number = 0;
        //This determines if player is walking
        protected var _playerWalking:Boolean = false;
        //awaiting a decision from the user
        protected var _awaitingDecision:Boolean = false;
        //play thought messages (reset once triggered)
        protected var messageArray:Array;
        protected var voiceIdArray:Array;
        protected var voiceSounds:Array;
        //This creates new message instances when needed
        protected var _message:Message;
        // store all position arrows
        protected var positionArrowList:Array;
        // add to this throughout the act
        protected var levelActName:String = '';

        public function getClockTime(clock:Date):String
        {
            var timeFormat:DateTimeFormatter = new DateTimeFormatter("en-UK");
            timeFormat.setDateTimePattern("HH:mm:ss");
            return String(timeFormat.format(clock));
        }

        /**
         * @return uint
         */
        public function getCurrentState():uint
        {
            return _currentState;
        }

        // this will introduce the act text
        /**
         * Set the current state of the level
         *
         * @param value
         */
        public function setCurrentState(value:uint):void
        {
            _currentState = value;
            if (BlueKarma.ENVIRONMENT === BlueKarma.TESTING) {
                var a:Achievement = new Achievement(0, "Changed to state: " + _currentState, 1);
                addChild(a);
            }
        }

        /**
         * @return _inventory
         */
        public function getInventory():Inventory
        {
            return _inventory;
        }

        /**
         * @return Dictionary
         */
        public function getItemsInInventory():Dictionary
        {
            if (_inventory === null) {
                throw new Error("Inventory does not exist");
            }
            return _inventory.getItemCollection();
        }

        public function setItemsInInventory(dictionary:Dictionary):void
        {
            _inventory.setItemCollection(dictionary);
        }

        public function getActScore():*
        {
            return this.actScore;
        }

        public function getLevelActName():String
        {
            if (levelActName === '') {
                throw new Error("Level Act Name not set! Set it");
            }
            return levelActName;
        }

        public function setLevelActName(value:String):void
        {
            levelActName = value;
        }

        public function cleanUp():void
        {
            throw new Error("CLEAN UP THE LEVEL!!!");
        }

        /**
         *
         * Methods
         *
         */

        protected function changeBackground():void
        {
            trace("changeBackground()");
        }

        protected function addActText(level:String, act:String, title:String, fadeIn:uint = 2, fadeOut:uint = 2, duration:uint = 4):void
        {
            var ai:ActIntroduction = new ActIntroduction(
                    level,
                    act,
                    title,
                    fadeIn,
                    fadeOut,
                    duration
            );
            ai.x = 312;
            ai.y = 354;
            addChild(ai);
        }

        protected function addGradientOverlay():void
        {
            trace("addGradientOverlay()");
        }

        protected function drawLevel():void
        {
            trace("drawLevel()");
        }

        protected function createNavigationArrows():void
        {
            trace("createNavigationArrows()");
        }

        protected function addNavigationArrows(index:uint = 0):void
        {
            trace("addNavigationArrows() at index: ", index);
        }

        protected function addPlayer():void
        {
            trace("addPlayer()");
        }

        protected function positionPlayer(xPos:Number, yPos:Number):void
        {
            if (_player !== null) {
                _player.x = xPos;
                _player.y = yPos;
            }
        }

        /**
         * Add Inventory to Level
         *
         * @param addChip
         */
        protected function addInventory(addChip:Boolean = false, debug:Boolean = false):void
        {
            _inventory = new Inventory(this, debug);
            addChild(_inventory);
            if (addChip) {
                _inventory.addPlayerchip();
            }
        }

        protected function userInteraction(allow:Boolean = false):void
        {
            trace("setting User Interaction to: ", allow);
            //if interaction is enabled: disable
            if (allow) {
                _interaction = true;
                addEventListener(TouchEvent.TOUCH, touchInteractionHandler);
            } else {
                _interaction = false;
                removeEventListener(TouchEvent.TOUCH, touchInteractionHandler);
            }
        }

        protected function addBackground():void
        {
            trace("adding background");
        }

        protected function addForeground():void
        {
            trace("adding foreground");
        }

        protected function goToBackgroundPosition(e:Event):void
        {
            trace("go to background position");
        }

        protected function goToForegroundPosition(e:Event):void
        {
            trace("go to foreground position");
        }

        protected function setWalkingBoundaries(debug:Boolean = false):void
        {
            trace("setting walking boundaries");
        }

        protected function displayCorrectNavigationArrows(bgPosition:uint):void
        {
            trace("displaying navigation arrows at position", bgPosition);
        }

        protected function initializeLevel():void
        {
            trace("initializing Level");
        }

        /**
         * Don't want to add a trace multiple times a second
         * @param event
         */
        protected function touchInteractionHandler(event:TouchEvent):void
        {
        }

        protected function interactionHandler(event:InteractionEvent):void
        {
            trace("handling interacion", event.data);
        }

        protected function onInteractionComplete(e:Event):void
        {
            trace("interaction has completed");
        }

        protected function createDecisionWheel(object:Object):void
        {
            userInteraction(false);
            if (!_awaitingDecision) {
                //waiting for decision from user
                _awaitingDecision = true;
                _overlay = new Overlay();
                addChild(_overlay);
                //create a new decision wheel
                _decisionWheel = new DecisionWheel(object);
                _decisionWheel.x = _decisionWheel.positionDecisionWheelX(object._x);
                _decisionWheel.y = _decisionWheel.positionDecisionWheelY(object._y);
                addChild(_decisionWheel);
                addEventListener("DecisionMade", proceedWithDecision);
            }
        }

        protected function proceedWithDecision(e:Event):void
        {
        }

        protected function handleLevelState(object:Object):void
        {
            trace("handleLevelStateObject id is: ", object._id);
        }

        protected function actionObject(name:String, type:String):void
        {
            trace("actionObject() name is: ", name);
            trace("actionObject() type is: ", type);
        }

        protected function chatObject(name:String, type:String):void
        {
            trace("chatObject() name is: ", name);
            trace("chatObject() type is: ", type);
        }

        protected function examineObject(name:String, type:String):void
        {
            trace("examineObject() name is: ", name);
            trace("examineObject() type is: ", type);
        }

        /**
         * Pass in id of thought message to play
         * Choose a delay (in seconds) before
         * triggering thought message
         *
         * @param    id
         * @param    delay
         */
        protected function triggerThoughtMessage(id:String, delay:uint = 0):void
        {
            if (id === '') {
                return;
            }
            messageArray = new Array();
            voiceIdArray = new Array();
            voiceSounds = new Array();
            messageArray = _repo.getThoughtId(id);
            voiceIdArray = _repo.getThoughtVoiceFile(id);
            var l:uint = voiceIdArray.length;
            for (var i:uint = 0; i < l; i++) {
                var voice:Sound = _repo.getVoiceFile(voiceIdArray[i]);
                voiceSounds[i] = voice;
            }
            if (delay == 0) {
                if (messageArray) {
                    dispatchEventWith("messageListener", true, {messages: messageArray[0], voices: voiceSounds});
                    resetThoughts();
                }
            }
            // wait certain period before triggering thought message
            if (delay > 0) {
                var timer:Timer = new Timer(1000, delay);
                timer.addEventListener(TimerEvent.TIMER_COMPLETE, thoughtMessageDelayHandler);
                timer.start();
            }
        }

        /**
         * Listen for triggered messages
         * @param e
         */
        protected function messageHandler(e:Event):void
        {
            if (_message != null) {
                // override any voice being played currently
                _message.terminateMessage();
                // reset message var
                _message = null;
            }
            // get array of messages
            var messageList:Array = e.data.messages;
            // get array of sounds that go with the messages
            var voiceList:Array = e.data.voices;
            // create a new message
            _message = new Message(messageList, voiceList);
            parent.addChild(_message);
        }

        protected function itemHandler(e:Event):void
        {
            trace("triggered item handler");
            var id:String = e.data._id;
            var obj:Item = Item(e.target) as Item;
        }

        /**
         * Is the player colliding with an object
         *
         * @param    player
         * @param    interactionObject
         * @return bool
         */
        protected function playerAndObjectColliding(player:AbstractPlayer, interactionObject:InteractionObject):Boolean
        {
            var playerRect:Rectangle = player.getBounds(this);
            var objectRect:Rectangle = interactionObject.getBounds(this);
            var isColliding:Boolean = playerRect.intersects(objectRect);
            return isColliding;
        }

        /**
         *
         */
        protected function listenForGesture():void
        {
            addEventListener("GestureEvent", gestureHandler);
        }

        /**
         *
         */
        protected function removeGestureListener():void
        {
            removeEventListener("GestureEvent", gestureHandler);
        }

        protected function gestureHandler(e:Event):void
        {
        }

        /**
         * Reset thoughts
         */
        protected function resetThoughts():void
        {
            messageArray = null;
            voiceIdArray = null;
            voiceSounds = null;
        }

        protected function removeDecisionWheel():void
        {
            _decisionWheel.removeDecisionWheel();
            _overlay.removeOverlay();
            //reset
            GameState.AWAITING_DECISION = false;
        }

        protected function activateListeners():void
        {
            addEventListener("messageListener", messageHandler);
        }

        protected function deactivateListeners():void
        {
            removeEventListener("messageListener", messageHandler);
        }

        protected function thoughtMessageDelayHandler(e:TimerEvent):void
        {
            if (messageArray !== null || voiceSounds !== null) {
                dispatchEventWith("messageListener", true, {
                            messages: messageArray[0],
                            voices: voiceSounds
                        }
                );
            }
        }

        /**
         * Should we disregard the touch target?
         *
         * @param target
         */
        protected function shouldIgnoreTarget(target:EventDispatcher, debug:Boolean = false):Boolean
        {
            if (debug) {
                trace(DisplayObject(target) as DisplayObject);
                trace(DisplayObject(target).parent as DisplayObject);
                trace(DisplayObject(target).parent.parent as DisplayObject);
                trace(DisplayObject(target).parent.parent.parent as DisplayObject);
                trace(DisplayObject(target).parent.parent.parent.parent as DisplayObject);
            }
            var targetImage:DisplayObject = Image(target).parent.parent.parent;
            if (targetImage is Inventory ||
                    targetImage is DecisionWheel ||
                    targetImage is PhoneButton ||
                    targetImage is PhoneMenu
            ) {
                return true;
            }
            return false;
        }

        protected function youHaveReminders():void
        {
            var modalYouHaveReminder:Modal = new Modal("Check the reminders in your phone");
            addChild(modalYouHaveReminder);
        }

        /**
         * Make item lose focus
         *
         * @return bool
         */
        protected function removeItemFocus():Boolean
        {
            if (_inventory.getItemInFocus()) {
                _inventory.loseItemFocus();
                triggerThoughtMessage("cant_do_that");
                return true;
            } else {
                return false;
            }
        }

        /**
         * This needs to calculate and then return total score of act
         *
         * return actScore;
         */
        protected function calculateScore():Number
        {
            throw new Error("This needs to be overriden by subclass");
        }

        /**
         * During the level there will be a need to start a timer
         *
         * @param length
         * @param iterations
         * @param whenFinishedFunction
         */
        private function startATimer(length:Number, iterations:Number, whenFinishedFunction:Function):void
        {
            var timer:Timer = new Timer(length, iterations);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, whenFinishedFunction);
            timer.start();
        }
    }
}