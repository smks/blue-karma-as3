package dialogue.character
{
	import adobe.utils.CustomActions;
    import assets.GameAssets;
    import assets.PhoneDialogueAssets;
	import starling.display.Button;
	import starling.events.Event;

    import global.Global;

    import dialogue.AbstractDialogue;
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.text.TextField;

    /**
     * ...
     * @author shaun stone
     */
    public class AbstractCharacterDialogue extends AbstractDialogue
    {
        protected const IN_CONVERSATION:uint = 1; // this is when riley and tyrone are talking
        protected const CONVERSATION_ENDED:uint = 2; // when the conversation has finished, waiting for user to end call
        protected const FINISHED:uint = 3; // when the user has closed the session
        protected var _convoTimer:TextField;
        protected var _convoText:TextField;
        protected var _convoTimerValue:uint;
        protected var _currentState:uint;
        protected var _messageVoiceFiles:Array;
        protected var _currentVoiceFile:Sound;
        protected var _speakers:Array;
        protected var _currentVoiceFileSoundChannel:SoundChannel;
        protected var _repo:*;
        protected var _regExp:RegExp;
		protected var awaitingDecision:Boolean = false;
        private var _textSlab:Image;
		private var noDecision:Button;
		private var maybeDecision:Button;
		protected var yesDecision:Button;

        public function AbstractCharacterDialogue()
        {
            _regExp = /(\t|\n|\r)/gi;
            super();
        }

        /**
         * This will get all xml messages and voice files
         *
         */
        override protected function fetchMessages():void
        {
            addMessagesToArray();
            addMessageVoiceFilesToArray();
            /**
             * debugging purposes
             */
            for (var i:uint = 0; i < _messages.length; i++) {
                trace(_messages[i]);
                trace(_messageVoiceFiles[i]);
            }
            /* */
        }

        public function getCurrentState():uint
        {
            return _currentState;
        }

        public function setCurrentState(value:uint):void
        {
            _currentState = value;
        }

        /*
         * END OF GAME LOGIC
         *******
         */
        public function setCounter(counter:uint):void
        {
            _messageCounter = counter;
        }

        public function getCounter():uint
        {
            return _messageCounter;
        }

        protected function promptDecision():void
        {
			setAwaitingDecision(true);
			
            trace("prompting decision from user");
        }
		
		protected function decisionMade():void
		{
			setAwaitingDecision(false);
			setMessageCounter(_messageCounter - 1);
			handlePhoneConversationIterator();
		}

        /**
         * Add the default background of phone dialogue
         *
         */
        protected function addDialogueBackground():void
        {
            //first draw bg
            _dialogueBg = new Image(GameAssets.getTexture("Overlay50"));
            addChild(_dialogueBg);
            _textSlab = new Image(PhoneDialogueAssets.getAtlas().getTexture("text-slab-bg"));
            _textSlab.x = 102;
            _textSlab.y = 480;
            addChild(_textSlab);
        }

        protected function addMessagesToArray():void
        {
            //prepare messages
            _messages = new Array();
            //pass message array from repo
            _messages = _repo.findMessagesByConvoId();
            _totalMessages = _messages.length;
            // add speakers also so we can determine who is speaking
            _speakers = _repo.findSpeakersByConvoId();
        }

        protected function addMessageVoiceFilesToArray():void
        {
            //prepare message voice files
            _messageVoiceFiles = new Array();
            //pass message voice files into dictionary
            _messageVoiceFiles = _repo.findMessageVoiceFilesByConvoId();
        }

        protected function handlePhoneConversationIterator():void
        {
			if (awaitingDecision === true) {
				return;
			}
			
            //check if messages exceeds total messages
            if (_messageCounter >= _totalMessages - 1) {
                handleConversationComplete();
            } else {

                // add 1 to message counter
                incrementMessageCounter();
                //if not then increase message counter
                showNextMessage();
				
				if (awaitingDecision === false) {
					//play the next voice file in pipe line
					handleConversationFlow();
				}
            }
        }

        protected function handleConversationComplete():void
        {
            //remove sound transform
            _currentVoiceFileSoundChannel.removeEventListener(flash.events.Event.SOUND_COMPLETE, whenStoppedSpeakingHandler);
            //set state to complete
            setCurrentState(CONVERSATION_ENDED);
            // let parent know conversation is over
            dispatchEventWith("dialogueFinished", true, {id: _convoId});
        }

        protected function handleConversationFlow():void
        {
            if (_messageCounter >= _totalMessages) {
                return;
            } else {
                _currentVoiceFile = _repo.getVoiceFile(_messageVoiceFiles[_messageCounter]);
                _currentVoiceFileSoundChannel = _currentVoiceFile.play();
                _currentVoiceFileSoundChannel.addEventListener(flash.events.Event.SOUND_COMPLETE, whenStoppedSpeakingHandler);
            }
        }

        protected function showNextMessage():void
        {
            var textColour:uint;
            // change text colour based on who is speaking
            if (String(_speakers[_messageCounter]) === 'riley' ||
                    String(_speakers[_messageCounter]) === 'unknown') {
                textColour = Global.BLUE_KARMA_WHITE;
            } else {
                textColour = Global.BLUE_KARMA_DIALOGUE_BLUE;
            }
            if (_convoText == null) {
                _convoText = new TextField(
                        700,
                        100,
                        _messages[_messageCounter],
                        Global.DEFAULT_FONT,
                        20,
                        textColour
                );
                _convoText.x = 161;
                _convoText.y = 540;
                addChild(_convoText);
            } else {
                _convoText.color = textColour;
                _convoText.text = _messages[_messageCounter];
            }
        }
		
		protected function addDecisionButtons(yes:Boolean = true,no:Boolean = true, maybe:Boolean = false):void 
		{
			if (yes) {
				yesDecision = new Button(PhoneDialogueAssets.getAtlas().getTexture("yes"));
				yesDecision.x = 485;
				yesDecision.y = 200;
				yesDecision.addEventListener(starling.events.Event.TRIGGERED, yesChosen);
				addChild(yesDecision);
			}
			
			if (no) {
				noDecision = new Button(PhoneDialogueAssets.getAtlas().getTexture("no"));
				noDecision.x = 485;
				noDecision.y = 280;
				noDecision.addEventListener(starling.events.Event.TRIGGERED, noChosen);
				addChild(noDecision);
			}
			
			if (maybe) {
				maybeDecision = new Button(PhoneDialogueAssets.getAtlas().getTexture("maybe"));
				maybeDecision.x = 485;
				maybeDecision.y = 360;
				maybeDecision.addEventListener(starling.events.Event.TRIGGERED, maybeChosen);
				addChild(maybeDecision);
			}
		}
		
		protected function removeDecisions():void 
		{
			if (yesDecision !== null) {
				yesDecision.removeEventListener(starling.events.Event.TRIGGERED, yesChosen);	
				removeChild(yesDecision, true);
			}
			
			if (noDecision !== null) {
				noDecision.removeEventListener(starling.events.Event.TRIGGERED, noChosen);	
				removeChild(noDecision, true);
			}
			
			if (maybeDecision !== null) {
				maybeDecision.removeEventListener(starling.events.Event.TRIGGERED, maybeChosen);
				removeChild(maybeDecision, true);
			}
			
		}
		
		protected function yesChosen(e:starling.events.Event):void 
		{
			throw new Error("This should be overriden");
		}
		
		protected function noChosen(e:starling.events.Event):void 
		{
			throw new Error("This should be overriden");
		}
		
		protected function maybeChosen(e:starling.events.Event):void 
		{
			throw new Error("This should be overriden");
		}

        protected function whenStoppedSpeakingHandler(event:Object):void
        {
            trace(_messageCounter);
            _currentVoiceFile = null;
            handlePhoneConversationIterator();
        }
		
		public function getAwaitingDecision():Boolean 
		{
			return awaitingDecision;
		}
		
		public function setAwaitingDecision(value:Boolean):void 
		{
			awaitingDecision = value;
		}
    }
}