package bluekarma.components.decisions
{
    import assets.MenuAssets;

    import bluekarma.interactive.base.InteractionObject;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import assets.GameAssets;

    import starling.events.TouchEvent;

    import assets.CharacterDialogueAssets;

    import bluekarma.assets.sound.SoundAssets;

    import starling.events.TouchPhase;
    import starling.events.Touch;

    import flash.geom.Point;

    import settings.foregrounds.Overlay;

    import starling.textures.Texture;

    /**
     * ...
     * @author Shaun Stone
     */
    public class DecisionWheel extends Sprite
    {
        public static const NONE:String = "none"
        public static const EXAMINE:String = "examine"
        public static const CHAT:String = "chat";
        public static const ACTION:String = "action";
        private const WIDTH:uint = 288;
        private const HEIGHT:uint = 288;
        //decision made
        private var _currentAction:String = NONE;
        //current object id
        private var _currentObjectId:String;
        private var _currentObjectType:String;
        private var _currentInteractionObject:InteractionObject;
        //bg
        private var _overlay:Button;
        private var _decisionsWheelBg:Image;
        //3 buttons
        private var _examineButton:Button;
        private var _chatButton:Button;
        private var _actionButton:Button;
        private var _closeButton:Button;

        /**
         * @desc constructor
         * @param    object
         */

        public function DecisionWheel(interactionObject:Object)
        {
            //pass in the id of the object
            _currentObjectId = interactionObject._id;
            //get type of object
            _currentObjectType = interactionObject._type;
            //get the interationobject
            _currentInteractionObject = interactionObject._object;
            //add on added to stage listener
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         * @desc remove decision wheel
         */

        public function removeDecisionWheel():void
        {

            //reset decision
            _currentAction = NONE;
            //remove from stage
            removeFromParent(true);
        }

        /**
         *
         * @param    xPos
         * @return int
         */

        public function positionDecisionWheelX(xPos:int, bgPosition:uint = 1):int
        {
            var offsetX:Number = xPos + WIDTH;
            if (offsetX > Game.STAGE_WIDTH) {
                xPos = Game.STAGE_WIDTH - WIDTH;
            }
            return xPos;
        }

        /**
         *
         * @param    xPos
         * @return int
         */

        public function positionDecisionWheelY(yPos:int, bgPosition:uint = 1):int
        {
            if (_decisionsWheelBg == null) {
                drawDecisionWheel();
            }
            var offsetY:Number = yPos + HEIGHT;
            if (offsetY > Game.STAGE_HEIGHT) {
                yPos = Game.STAGE_HEIGHT - HEIGHT;
            }
            return yPos;
        }

        /**
         *
         * @return
         */

        public function getCurrentAction():String
        {
            return _currentAction;
        }

        /**
         *
         * @return
         */

        public function getCurrentObjectId():String
        {
            return _currentObjectId;
        }

        /**
         *
         * @return
         */

        public function getCurrentObjectType():String
        {
            return _currentObjectType;
        }

        /**
         *
         * @return
         */
        public function getCurrentInteractionObject():InteractionObject
        {
            return _currentInteractionObject;
        }

        protected function addCloseButton():void
        {
            _closeButton = new Button(GameAssets.getTexture("CloseButton"));
            _closeButton.x = _decisionsWheelBg.width - (_closeButton.width / 2);
            _closeButton.scaleX = 0.5;
            _closeButton.scaleY = 0.5;
            this.addChild(_closeButton);
            _closeButton.addEventListener(Event.TRIGGERED, ignoreObject);
        }

        /**
         * @desc on added to stage
         * @param    e
         */

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            //draw Decision Wheel
            drawDecisionWheel();
        }

        private function closeWheel(e:Event):void
        {
            this.removeDecisionWheel();
        }

        /**
         * @desc draw the decision wheel on the stage
         */

        private function drawDecisionWheel():void
        {
            if (_decisionsWheelBg != null) {
                return;
            }
            //draw background
            var dwBg:String = "decision_wheel_bg";
            _decisionsWheelBg = new Image(GameAssets.getAtlas().getTexture(dwBg));
            this.addChild(_decisionsWheelBg);
            //draw examine button
            _examineButton = new Button(GameAssets.getAtlas().getTexture("decision_wheel_examine"), "", GameAssets.getAtlas().getTexture("decision_wheel_examine_on"));
            _examineButton.x = 14;
            _examineButton.y = 14;
            this.addChild(_examineButton);
            //draw examine button
            _chatButton = new Button(GameAssets.getAtlas().getTexture("decision_wheel_chat"), "", GameAssets.getAtlas().getTexture("decision_wheel_chat_on"));
            _chatButton.x = 150;
            _chatButton.y = 14;
            this.addChild(_chatButton);
            //draw examine button
            _actionButton = new Button(GameAssets.getAtlas().getTexture("decision_wheel_action"), "", GameAssets.getAtlas().getTexture("decision_wheel_action_on"));
            _actionButton.x = 35;
            _actionButton.y = 151;
            this.addChild(_actionButton);
            //add close button
            addCloseButton();
            _examineButton.addEventListener(Event.TRIGGERED, examineObject);
            _chatButton.addEventListener(Event.TRIGGERED, chatToObject);
            _actionButton.addEventListener(Event.TRIGGERED, actionObject);
        }

        private function ignoreObject(e:Event):void
        {
            trace("ignore object called");
            //play sound
            SoundAssets.buttonClick2.play();
            //set current to examine
            _currentAction = NONE;
            //decision has been made
            decisionMade();
        }

        /**
         * @desc decision made was to examine an object
         * @param    e
         */

        private function examineObject(e:Event):void
        {
            trace("examined called");
            //SoundAssets.buttonClick1.play();
            //set current to examine
            _currentAction = EXAMINE;
            //decision has been made
            decisionMade();
        }

        /**
         * @desc decision made was to chat to an object
         * @param    e
         */

        private function chatToObject(e:Event):void
        {
            trace("chat called");
            //play sound
            //SoundAssets.buttonClick1.play();
            //set current to examine
            _currentAction = CHAT;
            //decision has been made
            decisionMade();
        }

        /**
         * @desc decision made was to action a object
         * @param    e
         */

        private function actionObject(e:Event):void
        {
            trace("action called");
            //play sound
            //SoundAssets.buttonClick1.play();
            //set current to examine
            _currentAction = ACTION;
            //decision has been made
            decisionMade();
        }

        private function decisionMade():void
        {
            trace("event dispatched and decision made");
            dispatchEventWith("DecisionMade", true);
        }
    }
}