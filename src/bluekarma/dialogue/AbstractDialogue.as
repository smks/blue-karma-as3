package dialogue
{
	import assets.PhoneDialogueAssets;
    import dialogue.plaques.Plaque;
	import starling.display.Button;

    import interfaces.IDialogue;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import dialogue.AbstractDialogueRepository;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractDialogue extends Sprite implements IDialogue
    {
        public const PLAQUE_LEFT_X:uint = 102;
        public const PLAQUE_RIGHT_X:uint = 661;
        public const PLAQUE_Y:uint = 92;
        protected var _convoId:String;
        protected var _messages:Array;
        protected var _currentSpeaker:String;
        protected var _dialogueBg:Image;
        protected var _playerImage:Image;
        protected var _recipientImage:Image;
        protected var _totalMessages:uint;
        protected var _messageCounter:uint = 0;
        protected var _convoOver:Boolean;
        protected var _leftPlaque:Plaque;
        protected var _rightPlaque:Plaque;
        protected var _rightPlaque2:Plaque;
        protected var _rightPlaque3:Plaque;

        public function AbstractDialogue()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         * @desc go to the next message when previous as finished
         */
        public function goToNextMessage():void
        {
        }

        /**
         *
         * @return conversation id
         */
        public function getConvoId():String
        {
            return _convoId;
        }

        /**
         * @desc set conversation id
         * @param    value
         */
        public function setConvoId(value:String):void
        {
            trace("setting convo id", value);
            _convoId = value;
        }

        /**
         * @desc increment message Counter
         */
        public function incrementMessageCounter():void
        {
            _messageCounter++;
        }

        public function getMessageCounter():uint
        {
            return _messageCounter;
        }

        public function setMessageCounter(counter:uint):void
        {
            _messageCounter = counter;
        }

        public function toggleRightPlaque():void
        {
            if (_rightPlaque.visible === true) {
                _rightPlaque.visible = false;
                _rightPlaque2.visible = true;
            } else {
                _rightPlaque.visible = true;
                _rightPlaque2.visible = false;
            }
        }

        /**
         * @desc this is where we draw the dialogue
         */
        protected function drawDialogue():void
        {
        }

        /**
         * @desc set up all variables
         */
        protected function composeDialogue():void
        {
        }

        /**
         * @desc change current speaker
         * @param    speaker
         */
        protected function toggleCurrentSpeaker(speaker:String):void
        {
        }

        /**
         * Add the necessary plaques (by default they are private)
         *
         * @param    leftPlaque
         * @param    rightPlaque
         */
        protected function addPlaques(leftPlaque:String = "private", rightPlaque:String = "private", additionalRightPlaque:String = '', secondAdditionalRightPlaque:String = ''):void
        {
            //now we get the plaques (riley and private number)
            _leftPlaque = new Plaque(leftPlaque);
            _leftPlaque.x = PLAQUE_LEFT_X;
            _leftPlaque.y = PLAQUE_Y;
            addChild(_leftPlaque);
            //recipient plaque
            _rightPlaque = new Plaque(rightPlaque);
            _rightPlaque.x = PLAQUE_RIGHT_X;
            _rightPlaque.y = PLAQUE_Y;
            addChild(_rightPlaque);
            if (additionalRightPlaque !== '') {
                _rightPlaque2 = new Plaque(additionalRightPlaque);
                _rightPlaque2.x = PLAQUE_RIGHT_X;
                _rightPlaque2.y = PLAQUE_Y;
                _rightPlaque2.visible = false;
                addChild(_rightPlaque2);
                if (secondAdditionalRightPlaque !== '') {
                    _rightPlaque3 = new Plaque(secondAdditionalRightPlaque);
                    _rightPlaque3.x = PLAQUE_RIGHT_X;
                    _rightPlaque3.y = PLAQUE_Y;
                    _rightPlaque3.visible = false;
                    addChild(_rightPlaque3);
                }
            }
        }

        /**
         * @desc fetch messages from repo
         */
        protected function fetchMessages():void
        {
        }

        /**
         * @desc on added to stage set up dialogue
         * @param event
         */
        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawDialogue();
            composeDialogue();
        }
    }
}